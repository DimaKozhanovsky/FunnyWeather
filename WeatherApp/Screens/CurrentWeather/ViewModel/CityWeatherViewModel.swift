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
    case success(CityWeatherModel, Data?)
    case weatherImage(CityWeatherModel )
}

final class CityWeatherViewModel: ObservableObject {
    //MARK: - Properties
    @Published var state: TodayViewState = .idle

    func getData() {
       
        NetworkService.shared.getWeather { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    self.state = .error
                case .success(let model):
                    self.state = .weatherImage(model)
                    self.getWeatherIcon(model: model  )
                }
            }
            
        }
        
    }
    //MARK : Publik Methods
    // Get  image  from the server and is displayed it via using main tread  
    func getWeatherIcon(model : CityWeatherModel ){
        
        let imageCode = model.weather.first?.codeIcon
        guard let imageCode = imageCode else {
            return
        }
        NetworkService.shared.getImage(imageCode: imageCode) { (result) in
            guard let result = result else {
                return
            }
            DispatchQueue.main.async {
                self.state = TodayViewState.success( model, result)
            }
        }
    }
    
   // This function is set the titles of the wind
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
