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
  
     
    static func getCurruntWeatherEndpoint(lat: Double, lon: Double) -> String {
        let endpoint = "weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        return baseURL + endpoint
    }
    static func getForecastWheater(lat: Double ,lon : Double ) -> String {
        let endpoint = " forecast/hourly?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        return baseURL + endpoint
    }
    
    static func reciveImage (code : String ) -> String {
        let endpoint = "http://openweathermap.org/img/wn/\(code)@2x.png"
        return endpoint
    }
    static  func getHourlyForecast ( lat : Double ,lon : Double) ->
    String {
        
        let edpoint = "https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        return edpoint
    }
}
