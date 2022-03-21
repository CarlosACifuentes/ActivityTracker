/*
App        : Assignment 2 - Frameworks App
Version    : Part1
--------------------------
 Group #10
--------------------------
Author     : Walter Edgardo Sancho
Student ID : 301202813
--------------------------
Author     : Carlos Cifuentes
Student ID : 301140805
--------------------------
Date       : 03/25/2022 - Part 1
--------------------------
*/

import Foundation
import CoreLocation

//Location manager
final class LocationManager{
    var manager: CLLocationManager
    
    init(){
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType = .fitness
    }
    
    func checkLocationAuthorization(){
        if manager.authorizationStatus != .authorizedWhenInUse{
            manager.requestWhenInUseAuthorization()
        }
    }
}
