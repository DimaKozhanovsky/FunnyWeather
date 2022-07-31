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
    let cod: String?
}
