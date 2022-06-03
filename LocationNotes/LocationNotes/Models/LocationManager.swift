//
//  LocationManager.swift
//  LocationNotes
//
//  Created by Dmitry Suprun on 03.06.2022.
//

import UIKit
import CoreLocation

struct LocationCoordinate {
    var lat: Double
    var lon: Double
    static func create(location: CLLocation)-> LocationCoordinate {
        return LocationCoordinate(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
    }
}


class LocationManager: NSObject, CLLocationManagerDelegate {

    static let sharedInstance = LocationManager()
    
    var manager = CLLocationManager()
    
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    var blockForSave: ((LocationCoordinate) -> Void )?
    
    func getCurrentLocation(block: ((LocationCoordinate) -> Void )?) {
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            
            print("User didn't give access location")
            return
        }
        blockForSave = block
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType = .other
        
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       let lc =  LocationCoordinate.create(location: locations.last!)
        blockForSave?(lc)
        
        manager.stopUpdatingLocation()
    }
    
    
}
