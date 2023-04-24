//
//  TodayBodyView.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 2.05.22.
//

import SwiftUI
import CoreLocationUI

@available(iOS 15.0, *)
struct TodayBodyView: View {
    
    //MARK: - Properties
    var model : TodayWheatherModel
    // тут получаем данные в структуре TodayWheatherModel
    
    @State var isShowShareView = false
    
    let weatherPlaceHolder = UIImage(systemName: "thermometer.sun")!
    //forced unwrapping (a!) to access the value wrapped inside a when a isn’t nil
    //
    //MARK: - Body
    var body: some View {
        VStack(alignment: .center ) {
            Text("Today")
                //  Button(action: model.shareWheather, label:{ Text("Share")})
            
            
        

            Image("MulticolorStripe")
                .frame(width: 1, height: 2)
            Spacer()
            Group{ 
                if let imageData = model.imageData {
                    Image(uiImage: UIImage(data: imageData) ?? weatherPlaceHolder)
                    //The nil-coalescing operator
                }
                else {
                    Image(uiImage: weatherPlaceHolder)
                }

                Text(model.model.name + ", " + model.model.sys.country)
                Text( String(model.model.main.temp) + "°C |" + (model.model.weather[0]).main)
                    .foregroundColor(.blue)
                    //. A modifier is a function itself Viewt hat returns self after some modifications have been made.
            }
         
            
            Button {
                isShowShareView = true
                    // в кложуре мы вызываем вызываем внутри функции
                    //    shareWheather()
            } label: {
                
                Text("Share")
            }
            .background(Color.red)
            //Share  шит вызвать на самом верхнем для старых осей 
//            Button(action: {
//                isShowLocationView = true
//            }) {
//                Text("Share")
//            }
//
            
            
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
        .sheet(isPresented: $isShowShareView) {
            ShareSheet(activityItems: [model.model.name," " , String(model.model.main.temp)] )
            
        }
        
      //  .preferredColorScheme(.dark)
}
        
}
//MARK: - Prewiew 
struct TodayBodyView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

