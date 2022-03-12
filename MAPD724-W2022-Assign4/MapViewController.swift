//
//  MapViewController.swift
//  MAPD724-W2022-Assign4
//
//  Created by Walter Sancho on 11/03/2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let loc = CLLocationCoordinate2DMake(34.927752,-120.217608)
        let span = MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
        let reg = MKCoordinateRegion(center:loc, span:span)
        mapView.region = reg
        let ann = MKPointAnnotation()
        ann.coordinate = loc
        ann.title = "Park here"
        ann.subtitle = "Fun awaits down the road!"
        mapView.addAnnotation(ann)
    }

}
//func setupLocationManager(){
//    locationManager.delegate = self
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest
//}
//
//
//
//func checkLocationsServices(){
//    if CLLocationManager.locationServicesEnabled(){
//    setupLocationManager()
//    }else{
//
//        }
//  }
//
//    func checkLocationAuthorization(){
//        switch CLLocationManager.authorizationStatus(){
//        case .authorizedWhenInUse:
//            break
//        case .denied:
//            break
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            break
//        case.authorizedAlways:
//            break
//    }
//}
//
//
////    extension MapViewController: CLLocationManagerDelegate {
////        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
////
////        }
////
////        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
////            <#code#>
////        }
////    }
