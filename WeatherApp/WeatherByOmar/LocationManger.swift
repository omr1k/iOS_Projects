//
//  LocationManger.swift
//  WeatherByOmar
//
//  Created by Omar Khattab on 22/11/2022.
//

import CoreLocation

class LocationManger: NSObject, CLLocationManagerDelegate , ObservableObject{
    
    var manager = CLLocationManager()
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        requestLocationUpdates()
    }
    
    func requestLocationUpdates() {
        switch manager.authorizationStatus {
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            
        default:
            manager.requestWhenInUseAuthorization()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        print(lastKnownLocation as Any)
    }
}
