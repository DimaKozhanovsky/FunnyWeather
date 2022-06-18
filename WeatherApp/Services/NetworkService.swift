//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 1.05.22.
//

import Foundation
import CoreLocation

enum NetworkError: Error { // simple enum to handle network erors from the side of the server
    case badUrl
    case noData
    case decodingError
}
 


extension URL { // A simple extension helps us to prevent  the force unwrap we likely have to copy over throughout our codebase by using a custom initializer .Allows us to keep our implementation code clean from unwraps
    static func weaterURL( lat : Double , lon : Double) -> URL? {
        guard let url = URL(string: Endpoints.getCurruntWeatherEndpoint(lat:lat , lon: lon)) else {
            return nil
        }
        return url
    }
}


class NetworkService {
    
    let imageCache = NSCache<NSString,NSData>()
    
    static let shared = NetworkService()
    
    private init() {}
    
    
    
    func getWeather(location : CLLocation ,complition: @escaping (Result<AllDataForTodayWeatherModel, NetworkError>) -> Void) {
        guard let url = URL.weaterURL(lat: location.coordinate.latitude, lon: location.coordinate.longitude ) else {
            return complition(Result.failure(.badUrl))
        }
//        (lat: 53.893009, lon:27.567444
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return complition(.failure(.noData))
            }
            
            if let response = response {
                print(response)
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(AllDataForTodayWeatherModel.self, from: data)
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
