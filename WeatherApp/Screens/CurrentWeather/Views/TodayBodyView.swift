//
//  TodayBodyView.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 2.05.22.
//

import SwiftUI

struct TodayBodyView: View {
    var model: CityWeatherModel
    
    var body: some View {
        VStack(alignment: .center ) {
            Text("Today")
            Image("MulticolorStripe")
                .frame(width: 1, height: 2)
            Spacer()
            Group{
                Image(systemName:"sun.max")
                
                    .frame(width:100 , height: 100)
                    .scaleEffect(3)
                    .foregroundColor(.yellow)
                Text(model.name + ", " + model.sys.country)
                Text("22°С | Sunny")
                    .foregroundColor(.blue)
            }
            Spacer()
            Divider()
                .frame(width: 100)
                .foregroundColor(.gray)
            
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
    }
}

struct TodayBodyView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
