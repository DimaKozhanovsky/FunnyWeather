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
    
    let imageCache = NSCache<NSString,NSData>()
    
    static let shared = NetworkService()
    
    private init() {}
    
    
    
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
    func getImage( imageCode : String, completion: @escaping (Data?) -> Void) {
        let urlString =  Endpoints.reciveImage(code: imageCode)
      guard let url = URL(string: urlString) else {
        completion(nil)
        return
      }
      if let cacheImage = imageCache.object(forKey: NSString(string: urlString)) {
        completion(cacheImage as Data)
      } else {
        URLSession.shared.dataTask(with: url) { data, response, error in
          guard error == nil, let data = data else {
            completion(nil)
            return
          }
          self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
          completion(data)
        }.resume()
      }
    }

}
