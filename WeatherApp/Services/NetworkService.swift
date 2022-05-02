//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 1.05.22.
//

import Foundation

class NetworkService {
    func getData(response: @escaping (Result<CityWeatherModel, Error>) -> Void) {
        let url = URL(string: Endpoints.getCurruntWeatherEndpoint(lat: 53.893009, lon: 27.567444))
    }
}

