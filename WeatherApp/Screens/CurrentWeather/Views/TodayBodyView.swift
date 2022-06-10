//
//  TodayBodyView.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 2.05.22.
//

import SwiftUI

struct TodayBodyView: View {
    
    //MARK: - Properties
    var model : TodayWheatherModel
    
    let weatherPlaceHolder = UIImage(systemName: "thermometer.sun")!
    //MARK: - Body
    var body: some View {
        VStack(alignment: .center ) {
            Text("Today")
            Image("MulticolorStripe")
                .frame(width: 1, height: 2)
            Spacer()
            Group{ 
                if let imageData = model.imageData {
                    Image(uiImage: UIImage(data: imageData) ?? weatherPlaceHolder)
                }
                else {
                    Image(uiImage: weatherPlaceHolder)
                }
//
//                    .frame(width:100 , height: 100)
//                    .scaleEffect(3)
//                    .foregroundColor(.yellow)
                Text(model.model.name + ", " + model.model.sys.country)
                Text( String(model.model.main.temp) + "°C |" + (model.model.weather[0]).main)
                    .foregroundColor(.blue)
            }
            Spacer()
            Divider()
                .frame(width: 100)
                .foregroundColor(.gray)
            
            VStack {
                HStack( spacing: 80) {
                    VStack{
                    Image(systemName: "cloud.rain")
                        Text(String(model.model.rain?.volume ?? 111 ))
                            .foregroundColor(.black)
                    }
                    VStack{
                    Image(systemName: "humidity")
                        Text(String (model.model.main.humidity))
                            .foregroundColor(.black)
                    }
                    VStack{
                        Image(systemName: "thermometer.sun")
                        Text(String(model.model.main.pressure))
                            .foregroundColor(.black)
                    }
                }
                
    
                HStack(spacing: 70){
                    VStack{
                    Image(systemName: "wind")
                        Text(String(model.model.wind.speed) + "M/h")
                            .foregroundColor(.black)
                        
                    }
                    VStack{
                    Image(systemName: "safari")
                           Text("SE")
                            .foregroundColor(.black)
                }
               
                
            }
            }
            .foregroundColor(.yellow)
//            Group{
//                Divider()
//                    .frame(width: 100)
//                    .foregroundColor(.gray)
//                Spacer()
//                Button("Share", action:{
//                    CityWeatherModel()
//
//                Spacer()
//
//                Spacer()
//                Divider()
//            }
//
//        }
    }
}
}
//MARK: - Prewiew 
struct TodayBodyView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

