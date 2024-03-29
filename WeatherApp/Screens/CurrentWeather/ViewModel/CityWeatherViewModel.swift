//
//  CityWeatherViewModel.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 1.05.22.
//

import Foundation
import CoreLocation

enum TodayViewState {
    case idle
    case error
    case recievedWheather(TodayWheatherModel)
        // кейс имеет значение внутри себя ( чтобы содать последний кейс нужно передать в него ( в кейс) TodayWheatherModel)
}


//manage state from external objects with ObservableObject
final class CityWeatherViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var state: TodayViewState = .idle
    // переменная  отвечает за состояние нашего вью
     
    
    func getData() {
        
        let location = LocationManager.shared.userLocation
        NetworkService.shared.getWeather(location: location ?? CLLocation(latitude:51.509865,   longitude: -0.118092)) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    self.state = .error
                case .success(let model):
                        //
                    let wheather = TodayWheatherModel(model:model , imageData: nil, shareWheather: self.shareWheather)
                    self.state = .recievedWheather(wheather)
                    self.getWeatherIcon(model: model  )
                }
            }
            
        }
        
    }
    //MARK : Publik Methods
    // Get  image  from the server and is displayed it via using main tread  
        
    func getWeatherIcon(model : AllDataForTodayWeatherModel ){
       // тут только описние
        let imageCode = model.weather.first?.codeIcon
        guard let imageCode = imageCode else {
            return
        }
        NetworkService.shared.getImage(imageCode: imageCode) { (result) in
                //  в резаулт ловлю то что пришло в дату
            guard let result = result else {
                return
            }
            DispatchQueue.main.async {
                // любое отоображение на вью через  мейн поток юрд сешшион всегда в бекраунде
                self.state = TodayViewState.recievedWheather(TodayWheatherModel(model: model, imageData: result, shareWheather: self.shareWheather ))
                    // указываем через селф потому чо в кложуре в  self.state = TodayViewState в энам ложим TodayWheatherModel
            }
        }
        // второй параметр до скобок
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
    
    func shareWheather() {
            
        }
    let location = LocationManager.shared.userLocation
}

