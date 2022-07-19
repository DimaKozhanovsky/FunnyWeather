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
struct ForeCastWeatherModel : Decodable {
    let cod: String?
    let message, cnt: Int?
    let list: [List]?
    let city: City?
}

// MARK: - City
struct City : Decodable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}

// MARK: - Coord
struct Coord  : Decodable{
    let lat, lon: Int?
}

// MARK: - List
struct List : Decodable {
    let dt: Int?
    let main: MainClass?

ппп
    let visibility: Int?
    let pop: Double?


    let dtTxt: String?
}



// MARK: - MainClass
struct MainClass : Decodable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?
}

// MARK: - Rain

// MARK: - Sys


enum Pod : Decodable {
    case d
    case n
}

// MARK: - Weather





enum MainEnum :Decodable {
    case clouds
    case rain
}

enum Description : Decodable {
    case brokenClouds
    case heavyIntensityRain
    case lightRain
    case moderateRain
    case overcastClouds
    case scatteredClouds
}

// MARK: - Wind
