//
//  CellForecastView.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 01/07/2022.
//

import SwiftUI

struct CellForecastView: View {
    // let weatherPlaceHolder = UIImage(systemName: "sun")!
    var model : ForecastWeatherModel
    //статические функции как и статические свойства нужны для того чтобы не зависить от эксемпялра класса .
        //Статические свойства - свойства типа . Обращение к ним производится по имени класса.
    // static func как final class func
    var body: some View {
        Spacer()
        Text("London")
        Image("MulticolorStripe")
            .frame(width: 1, height: 2)
        HStack {
            Text("Today")
            Spacer()
        }
        
        List(1..<5) { item in
            ZStack{
                HStack {
                    Image(systemName: "cloud.rain")
                        .previewDisplayName("Вася")
                        .scaleEffect(2.3)
                        .padding(34)
                        .foregroundColor(Color.yellow)
                    VStack {
                        
                        //    Text(String(model.list[0].current.temperatureForecast ?? 44))
                        
                        Text("Сlear")
                    }
                    Spacer()
                    Text("22")
                    //   Text(String(model.listforForeCast?[0].current?[0].temperatureForecast ?? 222))
                        .padding(40)
                        .scaleEffect(2.5)
                        .foregroundColor(Color.blue)
                }
                
                Rectangle().stroke(lineWidth: 2).frame( idealWidth: .infinity,  maxHeight: 85 ).tag("1").foregroundColor(Color.blue)
                
                
            }
            .padding(.horizontal , -15 )
            
        }
        //   .listStyle(.grouped)
        //Making functions chainable is quite easy and can allow us to write using an almost DSL-like syntax.}
    }
    
}
