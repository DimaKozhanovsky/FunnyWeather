//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 27.05.22.
//

import CoreLocation // Core Location provides services that determine a device’s geographic location, altitude, and orientation, or its position relative to a nearby iBeacon device. The framework gathers data using all available components on the device, including the Wi-Fi, GPS, Bluetooth, magnetometer, barometer, and cellular hardware.

class LocationManager : NSObject ,ObservableObject { // ObservableOblect means that smt need to be observed
    private let manager = CLLocationManager()
    static let shared = LocationManager() // creating an object to achive it anywhere singletone
    var userLocation : CLLocation? //The latitude, longitude, and course information reported by the system
    
    override init()
    { // . If you want to provide the same initializer for a subclass that the parent class already has, you have to use the override keyword.
        
        super.init() // delegated up
        
        manager.delegate = self // points out on the propierty inside the class
      
        manager.desiredAccuracy = kCLLocationAccuracyBest
        sheduling()
    }
    // updating location every time when we call this method
    
   
    
    func sheduling ( ) {
         Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(updateCurrentLocation), userInfo: nil, repeats: true)
        print("it works")
       
    }
    @objc func updateCurrentLocation() {
        
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
}

extension LocationManager : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("Debug: Not determined ")
        case .restricted:
           print( "Debug: Restricted ")
        case .denied:
            print("Debug: Denied")
        case .authorizedAlways:
           print("Debug:Auth always")
        case .authorizedWhenInUse:
           print( "Debug: Auth when in use ")
        
        @unknown default : //@unknow default  which warns us about the missing case
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.userLocation = location
        manager.stopUpdatingLocation() // take location and stop it
    }
}

    
