//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 27.05.22.
//

import CoreLocation // Core Location provides services that determine a device’s geographic location, altitude, and orientation, or its position relative to a nearby iBeacon device. The framework gathers data using all available components on the device, including the Wi-Fi, GPS, Bluetooth, magnetometer, barometer, and cellular hardware.

class LocationManager : NSObject ,ObservableObject { // ObservableOblect means that smt need to be observed
    private let manager = CLLocationManager()
    static let shared = LocationManager() // creating an object to achive it anywhere singletone ,  обращаемся к этому объекту когда жмем однократно 
    var userLocation : CLLocation? //The latitude, longitude, and course information reported by the system
    
    override init()
    { // . If you want to provide the same initializer for a subclass that the parent class already has, you have to use the override keyword.
        
        super.init() // delegated up
        
        manager.delegate = self // points out on the propierty inside the class
      
        manager.desiredAccuracy = kCLLocationAccuracyBest
        sheduling()
    }
    // updating location every time when we call this method
    
//    var timer : Timer?
    
    func sheduling ( ) {
//        timer = Timer.scheduledTimer(timeInterval: 4 (если поставить 3600 то будет обновляться каждый час )  , target: self, selector: #selector(updateCurrentLocation), userInfo: nil, repeats: true)
//       print("it works")
//
//        timer?.invalidate()
        //Таймер очень бьеи по производительности !
       
        // таймер нужжно создать и уничтожить тут же чтоб он не рабботал постоянно
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
//    @objc func updateCurrentLocation() {
//
//        manager.requestAlwaysAuthorization()
//        manager.startUpdatingLocation()
//    }
}

extension LocationManager : CLLocationManagerDelegate{
    // это попап о локации
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status:
        CLAuthorizationStatus) {
        //  метод каждый раз срабатывет когда мы выбирам что то (однократно  и тд)
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
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:
    [CLLocation]) {
        // метод вызывается много раз по дефолту ( может раз в секнду )
        guard let location = locations.last else {return}
        self.userLocation = location
        manager.stopUpdatingLocation() // take location and stop it
    }
}

    
