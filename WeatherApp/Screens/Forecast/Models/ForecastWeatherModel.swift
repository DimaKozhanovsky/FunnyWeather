//
//  ForecastWheatherModel.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 18.06.22.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cityWeatherModel = try? newJSONDecoder().decode(CityWeatherModel.self, from: jsonData)



// MARK: - CityWeatherModel
struct ForecastWeatherModel : Decodable {
    let list : [ForeCastForNextDays]? 
    
    
}
 struct ForeCastForNextDays : Decodable ,Identifiable{
     var id = UUID() // уникальный код объекта чтоб сравнивать 2 погоды (2 обьекта) чтоб вручну
    let dt : Int?
    let main : Parameters?
    let weather : [IconsForForecast]?
     enum CodingKeys : String, CodingKey {
         case dt
         case main
         case weather
     }
}


struct Parameters : Decodable {
    let temp : Double?
}

struct IconsForForecast : Decodable {
    let main : String?
    let description : String?
    let icon : String?
}

