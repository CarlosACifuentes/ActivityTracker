//
//  MapViewController.swift
//  MAPD724-W2022-Assign4
//
//  Created by Walter Sancho on 11/03/2022.
//

import UIKit
import MapKit
import CoreLocation

class RunMapViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var totalKmLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    private var locationManager = LocationManager()
    private var startLocation: CLLocation!
    private var endLocation: CLLocation!
    
    private var runDistance = 0.0
    private var elapsedTime = 0
    private var timer = Timer()
    let listItems = UserDefaults.standard
    

    // Add new workout polylines
    var polylines: [MKPolyline] = []
    private var formattedNewLocations: [CLLocationCoordinate2D] = []
    var userWeight = 0.0
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hide back button for RunMapViewController
        self.navigationItem.setHidesBackButton(true, animated: true);
        userWeight = Double(listItems.string(forKey: "userWeight")!)!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.manager.delegate = self
        startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopRunning()
        super.viewWillDisappear(animated)
    }
    
    //stop button functionality
    @IBAction func onStopButtonClick(_ sender: UIButton) {
        let confirmAlert = UIAlertController(title: "Stop Running", message: "Are you sure you want to stop?.", preferredStyle: UIAlertController.Style.alert)

        confirmAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.stopRunning()
                self.navigationController?.popViewController(animated: true)
            }))

        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                  
            }))

            self.present(confirmAlert, animated: true, completion: nil)
    }
    
    //function to start running
    private func startRunning(){
        locationManager.manager.startUpdatingLocation()
        startTimer()
    }
    
    //function to start the timer
    private func startTimer(){
        elapsedTimeLabel.text = self.getTimeString(elapsedTime: self.elapsedTime)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    //function to stop running
    private func stopRunning(){
        locationManager.manager.stopUpdatingLocation()
        stopTimer()
    }
    
    //function to stop the timer
    private func stopTimer(){
        timer.invalidate()
        elapsedTime = 0
    }
    
    //function to ge the time in string format fiven an int value
    private func getTimeString (elapsedTime: Int) -> String{
        let hours = elapsedTime / 3600
        let minutes = (elapsedTime % 3600) / 60
        let seconds = (elapsedTime % 3600) % 60
        
        if(seconds < 0){
            return "00:00:00"
        }else{
            if(hours == 0){
                return String(format: "%02d:%02d", minutes, seconds)
            }else {
                return String(format: "%02d:%02d", hours, minutes)
            }
        }
    }
    
    //function to ge the time in string format fiven an int value
    private func getTimeInMinutes (elapsedTime: Int) -> Double{
        return Double (elapsedTime % 3600)/60
    }
    
    //updates timer by 1 second
    @objc private func updateTimer(){
        self.elapsedTime += 1
        elapsedTimeLabel.text = self.getTimeString(elapsedTime: self.elapsedTime)
        //MET for running = 9.8 @ 6mph-9.6km/h
        // Formula for calories burned = minutes of activity * 3.5 * MET * user weight /200
        caloriesLabel.text = String(format: "%.0f", self.getTimeInMinutes(elapsedTime: self.elapsedTime) * 3.5 * 9.8 * userWeight / 200)
    }
    
    @IBAction func onMapTypeSelect(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
              case 0:
                  mapView.mapType = .standard
              case 1:
                  mapView.mapType = .satellite
              default:
                  mapView.mapType = .hybrid
              }
    }
    
}
    //MKMapViewDelegate
    extension RunMapViewController: MKMapViewDelegate {
        // set user location and follow
        func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
        
        //update runDistance and current run ovelay on map
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if startLocation == nil {
                startLocation = locations.first
            } else if let location = locations.last{
                runDistance += endLocation.distance(from: location)
                //km with only 1 decimal for metes
                self.totalKmLabel.text = String(format: "%.1f", runDistance/1000)
                
                self.speedLabel.text = String(format: "%.1f",manager.location!.speed*18/5)
            }
            endLocation = locations.last

            //update current run overaly on the map - polylines
            // Format locations
            let formattedLocation = CLLocationCoordinate2D(
                latitude: endLocation.coordinate.latitude,
                longitude: endLocation.coordinate.longitude
            )
            formattedNewLocations.append(formattedLocation)
            
            //Add new polyline to map
            let newPolyline = MKPolyline(coordinates: formattedNewLocations, count: formattedNewLocations.count)
            polylines.append(newPolyline)
            mapView.addOverlay(newPolyline)

        }
        
        //function to render polylines
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            var lineRenderer = MKPolylineRenderer()
            if let polyline = overlay as? MKPolyline {
                lineRenderer = MKPolylineRenderer(polyline: polyline)
                // if mapview maptype is standard the polyline is blue, else it is yellow
                if mapView.mapType == .standard{
                    lineRenderer.strokeColor = .blue
                }else {
                    lineRenderer.strokeColor = .yellow
                }
                lineRenderer.lineWidth = 2.0
            }
            return lineRenderer
        }
        
    }
