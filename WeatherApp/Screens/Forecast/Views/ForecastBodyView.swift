//
//  ForecastBodyView.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 18.06.22.
//

import Foundation
import SwiftUI

struct   ForecastBodyView : View {
    
    var model : ForecastWeatherModel? //  не должна быть опционалом если не @State и не @Binding ( нет инита )  , потому что форкаст это структура при перересовки стирается сылка на подкрепляющую её модельку . Это же структура)
    var body: some View {
        VStack( spacing: 20){
            Image("MulticolorStripe")
                .resizable()
                .frame(height: 50)
            if  let list = model?.list {
                //  в дебагре возвращается обратно если поставить на брейкпоинт на 19 так как это начало  функции . Комментарии сбивают дебагер надо запускаь заново
                // If variable model exists and it has property "list" then code in {} will be executed
                // we combined the computation and evaluation within a single statement by using if let.
                List(list)
                // пришло с сервера 40 вью
                { item in      // делает ячейки на экране и 2-или 3 вне экрана (в зависимомти от размеров )
                    if #available(iOS 15.0, *) {
                        CellForecastView(model: item)
                            .listRowSeparator(.hidden)
                    } else {
                        // Fallback on earlier versions
                    }
                }
            } else {
                Text("Пиздец")
            }
            //   .listStyle(.grouped)
            //Making functions chainable is quite easy and can allow us to write using an almost DSL-like syntax.}
            
        }
        if #available(iOS 15.0, *) {
            //  в if нельзя вызывать модификтор только ко вью можно применять
            //  не ЗАБВАТЬ ТОЧКУ!!!!!!!!!! для модификатров
//            .listRowSeparator(.hidden)
        } else {
            // Fallback on earlier versions
        }
        
    }
}




struct ForecastBodyView_Previews : PreviewProvider {
    static var previews: some View {
        ForecastBodyView()
    }
}
