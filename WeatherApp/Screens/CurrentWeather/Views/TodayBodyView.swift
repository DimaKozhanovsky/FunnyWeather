//
//  TodayBodyView.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 2.05.22.
//

import SwiftUI

struct TodayBodyView: View {
    
    //MARK: - Properties
    var model: CityWeatherModel
    var imageData : Data?
    let weatherPlaceHolder = UIImage(systemName: "thermometer.sun")!
    //MARK: - Body
    var body: some View {
        VStack(alignment: .center ) {
            Text("Today")
            Image("MulticolorStripe")
                .frame(width: 1, height: 2)
            Spacer()
            Group{
                if let imageData = imageData {
                    Image(uiImage: UIImage(data: imageData) ?? weatherPlaceHolder)
                }
                else {
                    Image(uiImage: weatherPlaceHolder)
                }
//
//                    .frame(width:100 , height: 100)
//                    .scaleEffect(3)
//                    .foregroundColor(.yellow)
                Text(model.name + ", " + model.sys.country)
                Text( String(model.main.temp) + "°C |" + (model.weather[0]).main)
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
                        Text(String(model.rain?.volume ?? 111 ))
                            .foregroundColor(.black)
                    }
                    VStack{
                    Image(systemName: "humidity")
                        Text(String (model.main.humidity))
                            .foregroundColor(.black)
                    }
                    VStack{
                        Image(systemName: "thermometer.sun")
                        Text(String(model.main.pressure))
                            .foregroundColor(.black)
                    }
                }
                
    
                HStack(spacing: 70){
                    VStack{
                    Image(systemName: "wind")
                        Text(String(model.wind.speed) + "M/h")
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
//MARK: - Prewiew 
struct TodayBodyView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
