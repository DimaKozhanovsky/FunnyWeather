//
//  Today.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 23.04.22.
//

import SwiftUI

struct TodayView: View {
    
    @StateObject var cityWeatherViewModel = CityWeatherViewModel()
    // @StateObject creates by view itself ,an Observable Object you are watching for changes ,  то есть мы сами отслеживаем изменения в этом объекте
    //we can use ObservableObjectPublisher and send notifications manually using eventswillSet()
    
    var body:  some View {
        // some View : he whole point of the some keyword is to declare a "generic"(reverse) that satisfies the View protocol
        // Viewt his is primarily a structure that stores all the parameters necessary to generate an image on the screen. Including assembly instructions, which is Content . Thus, a declarative-style closure ( Content) processed with ViewBuilder(ввав : View) => some View  returns us a View.
        switch cityWeatherViewModel.state {
            
        case .idle:
            ProgressView()
                .onAppear {
                    //  в скобках { тут содаем функцию} мы пердаем сюда кложур как тип парметра
                    // до появления вью добваится экшен который сработает до появления
                    // .onAppear this is a function (method of View protocol that extracts Content from the modified View) , which one passes into func body (content : Content )=> some View (Where Content is a declarative-style closure).
          
                    cityWeatherViewModel.getData()
                    // функция не влиет на вью получаем данные перед тем как появится прогрес вью
                    
                }
                .frame(width:33)
                // потом когда выполнился онаипир (уже будет "новое вью") к нему применятеся модификтора frame которое возвращает тоже some View
            
        case .error:
            Text("Error")
            
        
    
        case .recievedWheather(let model) :
            if #available(iOS 15.0, *) {
                TodayBodyView(model: model )
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
}

struct Today_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}

//By the way, an interesting note. As an input parameter, background does not take a color, but a View. Those. The Color class is not just a description of a color, it is a full-fledged View, to which modifiers and so on can be applied. And as a background, respectively, you can pass other View.

// In general, Views should be kept as simple as possible. Complex constructions are best placed in separate View. Thus, entire chains of real types are replaced by one type - your CustomView, which allows the compiler not to go crazy with all this hash.
