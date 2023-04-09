//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 1.05.22.
//

import Foundation
import CoreLocation
import Combine

enum NetworkError: Error { // simple enum to handle network erors from the side of the server
    case badUrl
    case noData
    case decodingError
}
 


extension URL { // A simple extension helps us to prevent  the force unwrap we likely have to copy over throughout our codebase by using a custom initializer .Allows us to keep our implementation code clean from unwraps
    static func weatherURL( lat : Double , lon : Double) -> URL? {
        guard let url = URL(string: Endpoints.getCurruntWeatherEndpoint(lat:lat , lon: lon)) else {
            return nil
        }
        return url
    }
    
    static func weatherForecastURL(lat : Double , lon : Double) -> URL? {
        guard let url = URL(string: Endpoints.getForecastWheater(lat: lat, lon: lon)) // take lat and long from wheatherforecastURL
        else {
            return nil
        }
        return url
    }
}


class NetworkService  : Error {
 

    typealias Headers = [String: Any]
    let imageCache = NSCache<NSString,NSData>()
    
    static let shared = NetworkService()
    
    private init() {}
    
    
    
    func getWeather(location : CLLocation ,complition: @escaping (Result<AllDataForTodayWeatherModel, NetworkError>) -> Void) {
        guard let url = URL.weatherURL(lat: location.coordinate.latitude, lon: location.coordinate.longitude )
        else {
            return complition(Result.failure(.badUrl)) // check if url incorrect and recive it as result im parametr complition
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
                // use try before function where rather just could be failed$
                let weatherResponse = try
                
                JSONDecoder().decode(AllDataForTodayWeatherModel.self, from: data)
                complition(.success(weatherResponse))
            } catch(let error) {
                print(error)
                return complition(.failure(.decodingError))
                
            }
            
        }.resume()
    }
        func getForcastWether(location : CLLocation , complition : @escaping (Result<ForecastWeatherModel , NetworkError>) ->Void ) {  //defenition of the type of data for frozen enum Result for closure complition
            guard let url = URL.weatherForecastURL(lat: location.coordinate.latitude, lon: location.coordinate.longitude) else {
                return complition(Result.failure(.badUrl))
            }
            URLSession.shared.dataTask(with: url) {
                data, response , error in
                guard let data = data , error == nil else {
                    return complition(.failure(.noData))
                }
                if let response = response {
                    print(response)
                }
                do {
                let weatherResponse = try JSONDecoder().decode(ForecastWeatherModel.self, from: data)
                complition(.success(weatherResponse))
                        } catch(let error) {
                            print(error)
                        return complition(.failure(.decodingError))
                    }
                }
            .resume()
            //If you look carefully at the way we do a network call, we aren’t immediately doing anything with the code inside of our dataTask. The dataTask method returns a URLSessionDataTask object that you can use for Asynchronous operations.
            
                
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
    func getImage(
            url: URL,
            headers: Headers
        ) -> AnyPublisher<Data, URLError> {
            var urlRequest = URLRequest(url: url)
            
            headers.forEach { (key, value) in
                if let value = value as? String {
                    urlRequest.setValue(value, forHTTPHeaderField: key)
                }
            }
            
            return URLSession.shared.dataTaskPublisher(for: urlRequest).map(\.data).eraseToAnyPublisher()
        }

}
