


// MARK: - CityWeatherModel
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cityWeatherModel = try? newJSONDecoder().decode(CityWeatherModel.self, from: jsonData)

import Foundation

// MARK: - CityWeatherModel
struct CityWeatherModel: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let sys: Sys
    let rain : Rain?
    var name: String
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int
}



// MARK: - Main
struct Main: Decodable {
    let temp: Double
    let pressure, humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        
    }
}

// MARK: - Sys
struct Sys: Decodable {
    
    let country: String
}

// MARK: - Weather
struct Weather: Decodable {
    
    let main: String
    let codeIcon : String
    
    enum CodingKeys: String, CodingKey {
        case  main
        case codeIcon = "icon"
    }
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double
}

struct Rain : Decodable {
    let volume : Double
}
