//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 18.06.22.
//

import Foundation
import CoreLocation
enum ForcastViewState {
    case idle
    case error
    case recivedForecastWheather(ForecastWeatherModel)
}
// creating enum to observe states of view
final class ForecastViewModel : ObservableObject{
    //. Mark a class final to tell the Swift compiler that a method should be called directly instead of looking it up from a method table.
   // A final class in Swift prevents the class from being inherited.
    @Published var state : ForcastViewState = .idle
    // is one of the most useful property wrappers in SwiftUI, allowing us to create observable objects that automatically announce when changes occur. SwiftUI will automatically monitor for such changes, and re-invoke the body property of any views that rely on the data.
    
    func getDataForForecast(){
        let location = LocationManager.shared.userLocation // creating object yo use
        //Nil-Coalescing Operator
        NetworkService.shared.getForcastWether(location: location ??  CLLocation(latitude:51.509865, longitude: -0.118092)) { result in
        DispatchQueue.main.async {
            switch result {
            case .failure(let error ) :
                print(error)
                self.state = .error //from array
            case .success(let model):
                self.state = .recivedForecastWheather(model)
                    // тут хранится модель если что то будет перерисовыывться то она будет браться из @Published var state
                
            }
        }
    }
}
}
