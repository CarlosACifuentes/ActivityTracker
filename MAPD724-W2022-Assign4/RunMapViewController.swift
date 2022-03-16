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
    private var locationManager = LocationManager()
    private var startLocation: CLLocation!
    private var endLocation: CLLocation!
    
    private var runDistance = 0.0
    private var elapsedTime = 0
    private var timer = Timer()
    

    // Add new workout polylines
    var polylines: [MKPolyline] = []
    private var formattedNewLocations: [CLLocationCoordinate2D] = []
    
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // check authorization
        locationManager.checkLocationAuthorization()
        
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

    @IBAction func onStopButtonClick(_ sender: UIButton) {
        self.stopRunning()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func startRunning(){
        locationManager.manager.startUpdatingLocation()
        startTimer()
    }
    
    private func startTimer(){
        elapsedTimeLabel.text = self.getTimeString(elapsedTime: self.elapsedTime)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func stopRunning(){
        locationManager.manager.stopUpdatingLocation()
        stopTimer()
    }
    
    private func stopTimer(){
        timer.invalidate()
        elapsedTime = 0
    }
    
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
    
    @objc private func updateTimer(){
        self.elapsedTime += 1
        elapsedTimeLabel.text = self.getTimeString(elapsedTime: self.elapsedTime)
    }
    
    
}
    
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
            }
            endLocation = locations.last

            //update current run overaly on the map - polylines
            // Format locations
            let formattedLocation = CLLocationCoordinate2D(
                latitude: endLocation.coordinate.latitude,
                longitude: endLocation.coordinate.longitude
            )
            formattedNewLocations.append(formattedLocation)

            let newPolyline = MKPolyline(coordinates: formattedNewLocations, count: formattedNewLocations.count)
            polylines.append(newPolyline)
            mapView.addOverlay(newPolyline)

        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            var lineRenderer = MKPolylineRenderer()
            if let polyline = overlay as? MKPolyline {
                lineRenderer = MKPolylineRenderer(polyline: polyline)
                lineRenderer.strokeColor = .blue
                lineRenderer.lineWidth = 2.0
            }
            return lineRenderer
        }
        
    }
