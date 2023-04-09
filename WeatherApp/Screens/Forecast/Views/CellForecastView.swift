//
//  CellForecastView.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 01/07/2022.
//

import SwiftUI

struct CellForecastView: View {
    // let weatherPlaceHolder = UIImage(systemName: "sun")!
    var model :  ForeCastForNextDays?
    //статические функции как и статические свойства нужны для того чтобы не зависить от эксемпялра класса .
        //Статические свойства - свойства типа . Обращение к ним производится по имени класса.
    // static func как final class func
  let  isDrawBordersOfCell : Bool 
    
  
    
    var body: some View {
        
       
        
        ZStack{
            HStack {
                if let imageCode = model?.weather?[0].icon{
                    NetworkImageView(imageUrlString:Endpoints.reciveImage(code:imageCode)) {
                        Image(systemName: "photo")
                            
                    } progressBlock: {
                       ProgressView()
                        
                    }
                    .frame(width: 100 , height: 100)
                    //  если не указывать хеит то по ширене этой ячейки 

                }
               
//                Text(String(model?.weather?[0].icon ?? "Нет иконки"))
//                    .previewDisplayName("Вася")
//                    .scaleEffect(2.3)
//                    .padding(34)
//                    .foregroundColor(Color.yellow)
                VStack {
                    
                    //    Text(String(model.list[0].current.temperatureForecast ?? 44))
                    
                    Text("Сlear")
                }
                Spacer()
                Text(String(model?.main?.temp ?? 0))
                //   Text(String(model.listforForeCast?[0].current?[0].temperatureForecast ?? 222))
                    .padding(40)
                    .scaleEffect(2.5)
                    .foregroundColor(Color.blue)
             
                
            }
            if isDrawBordersOfCell {
                Rectangle().stroke(lineWidth: 2).frame( idealWidth: .infinity,  maxHeight: 85 ).tag("1").foregroundColor(Color.blue)
                
            }
        }
        .padding(.horizontal , -15 )
        .contentShape(Rectangle())
        // контенйер шейп чтобы можно было тыкать потому что модификтор он там жестур кривой
        
       
    }
    
}
