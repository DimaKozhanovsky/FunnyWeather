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
    case recivedForecastWheather(ForecastWheatherModel)
}

final class ForecastViewModel : ObservableObject{
    @Published var state : ForcastViewState = .idle
    
    func getDataForForecast(){
        let location = LocationManager.shared.userLocation // creating object yo use
        //Nil-Coalescing Operato
        NetworkService.shared.getForcastWether(location: location ??  CLLocation(latitude:51.509865, longitude: -0.118092)) { result in
        DispatchQueue.main.async {
            switch result {
            case .failure(let error ) :
                print(error)
                self.state = .error //from array
            case .success(let model):
                let wheather = ForecastWheatherModel(model: model)
                
            }
        }
    }
}
}
