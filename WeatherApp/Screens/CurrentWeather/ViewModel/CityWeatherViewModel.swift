//
//  CityWeatherViewModel.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 1.05.22.
//

import Foundation

enum TodayViewState {
    case idle
    case error
    case success(CityWeatherModel)
}

class CityWeatherViewModel: ObservableObject {
    
    @Published var state: TodayViewState = .idle
    
    
    let networkService = NetworkService()
    
    func getData() {
        
        networkService.getWeather { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    self.state = .error
                case .success(let model):
                    self.state = .success(model)
                    
                }
            }
            
        }
        
    }
    
    func convertDegress (degrees : Double ) -> String {
        var out : String
        switch  degrees {
        case 0 :
            out = "N"
        case 0...45 :
            out = "NO"
        case 45...90:
            out = "O"
        case 90 ... 135:
            out = "SO"
        case 135...180 :
            out = "S"
        case 180...225 :
            out = "SW"
        case 225 ... 270 :
            out = "W"
        case 270 ... 315 :
            out = "NW"
            
        default :
            out = "Что то пошло не так "
        }
        return out
    }
    
}
