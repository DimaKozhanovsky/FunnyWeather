//
//  Endpoints.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 1.05.22.
//

import Foundation

struct Endpoints {
    static let baseURL = "https://api.openweathermap.org/data/2.5/"
    static let apiKey = "651e21ae2d554489aadd16a61048e96a"
    
    static let for4day = "forecast/hourly?lat={lat}&lon={lon}&appid={API key}"
    
    
    static func getCurruntWeatherEndpoint(lat: Double, lon: Double) -> String {
        let endpoint = "weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        return baseURL + endpoint
    }
}
