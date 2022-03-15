//
//  MapViewController.swift
//  MAPD724-W2022-Assign4
//
//  Created by Walter Sancho on 11/03/2022.
//

import UIKit
import MapKit
import CoreLocation

class RunMapViewController: UIViewController, CLLocationManagerDelegate {

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // check authorization
        locationManager.checkLocationAuthorization()
        
//        let loc = CLLocationCoordinate2DMake(34.927752,-120.217608)
//        let span = MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
//        let reg = MKCoordinateRegion(center:loc, span:span)
//        mapView.region = reg
//
//        //marker
//        let ann = MKPointAnnotation()
//        ann.coordinate = loc
//        ann.title = "Park here"
//        ann.subtitle = "Fun awaits down the road!"
//        mapView.addAnnotation(ann)
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
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if startLocation == nil {
                startLocation = locations.first
            } else if let location = locations.last{
                runDistance += endLocation.distance(from: location)
                self.totalKmLabel.text = String(runDistance)
            }
            endLocation = locations.last
        }
    }
