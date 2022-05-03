//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 1.05.22.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}


extension URL {
    static func weaterURL() -> URL? {
        guard let url = URL(string: Endpoints.getCurruntWeatherEndpoint(lat: 53.893009, lon: 27.567444)) else {
            return nil
        }
        return url
    }
}


class NetworkService {
    
    func getWeather(complition: @escaping (Result<CityWeatherModel, NetworkError>) -> Void) {
        guard let url = URL.weaterURL() else {
            return complition(Result.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return complition(.failure(.noData))
            }
            
            if let response = response {
                print(response)
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(CityWeatherModel.self, from: data)
                complition(.success(weatherResponse))
            } catch {
                return complition(.failure(.decodingError))
            }
        }.resume()
        
    }
    
}
