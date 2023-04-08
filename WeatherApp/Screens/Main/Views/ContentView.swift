//
//  ContentView.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 23.04.22.
//

import SwiftUI
//
struct ContentView: View {
    //MARK: - Properties
    init (){
       LocationManager.shared.sheduling()
    }
    @State var selectedTab : Int = 0
        // seletedTb ,будет иметь тип пабтшер и дженерика параметр типа  интеджер в данном коде
    // биндинг это обертка
    var body: some View {
        //MARK: - Body
       
        TabView(selection: $selectedTab, content: {
            // когда жали на форкс то перерисовался табвью . так не было seleteatab по дефолту перерисовывалась тодей вью 
            TodayView()
                .tabItem {
                    
                    Image(systemName:"sun.max")
                    Text("Today")
                }.tag(0)
            ForecastView()
                .tabItem{
                    // кнопка на которую смы жали
                    Image(systemName:"cloud.sun.rain")
                    Text("Forecast")
                }.tag(1)
        })
    }
}
//        extension ContentView {
//            enum Tab : Hashable {  // protocol Hashable is used to  able and store essences , in this case cases of enum Tab in arrays ( streamlined) or  Sets ( not stremlined)
//                case home
//                case more
//            }
//        }
//
//
//
//}

//MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

