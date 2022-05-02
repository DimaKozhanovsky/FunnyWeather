//
//  Today.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 23.04.22.
//

import SwiftUI

struct A: View {
    @ObservedObject var cityWeatherViewModel: CityWeatherViewModel
    
    var body: some View {
        Text(cityWeatherViewModel.model?.name ?? "")
    }
}

struct TodayView: View {
    
    @StateObject var cityWeatherViewModel = CityWeatherViewModel()
    
    var body: some View {
            if let model = cityWeatherViewModel.model {
                VStack(alignment: .center ){
                    A(cityWeatherViewModel: cityWeatherViewModel)
                    Text("Today")
                    Image("MulticolorStripe")
                        .frame(width: 1, height: 2)
                    Spacer()
                    Group{
                        Image(systemName:"sun.max")

                            .frame(width:100 , height: 100)
                            .scaleEffect(3)
                            .foregroundColor(.yellow)
                        Text(model.name)
                        Text("22°С | Sunny")
                            .foregroundColor(.blue)
                    }
                    Divider()
                        .frame(width: 100)
                        .foregroundColor(.gray)
                    Spacer()
                    Group{
                        HStack {
                            Image(systemName: "cloud.rain")
                            Image(systemName: "humidity")
                            Image(systemName: "thermometer.sun")
                        }
                        HStack{
                            Text("57%")
                            Text("1.0 mm")
                            Text("1019 hPa")
                        }
                        .foregroundColor(.black)
                        
                        HStack{
                            Image(systemName: "wind")
                            
                            Image(systemName: "safari")
                        }
                        HStack{
                            Text("20km/h")
                            Text("SE")
                        }
                        .foregroundColor(.black)
                    }
                    .foregroundColor(.yellow)
                    Group{
                        Divider()
                            .frame(width: 100)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("Share")
                        
                        Spacer()
                        
                        Spacer()
                        Divider()
                    }
                    
                }
                
            }  else {
                ProgressView()
                    .onAppear {
                        cityWeatherViewModel.getData()
                    }
            }
        
    }
}

struct Today_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
