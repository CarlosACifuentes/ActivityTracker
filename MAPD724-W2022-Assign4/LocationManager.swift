//
//  LocationManager.swift
//  MAPD724-W2022-Assign4
//
//  Created by Walter Sancho on 15/03/2022.
//

import Foundation
import CoreLocation

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
