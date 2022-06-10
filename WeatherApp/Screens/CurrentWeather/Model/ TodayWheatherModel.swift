//
//  Model2.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 22.05.22.
//

import Foundation
struct TodayWheatherModel { //The default memberwise initializer 
    var model: CityWeatherModel
    var imageData : Data?
    var shareWheather : ()->()
}
