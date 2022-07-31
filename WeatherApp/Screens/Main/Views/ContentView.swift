//
//  ContentView.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 23.04.22.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Properties
    init (){
       LocationManager.shared.sheduling()
    }
//        @State var selectedTab : Tab =
    var body: some View {
        //MARK: - Body
       
        TabView {
            TodayView()
                .tabItem {
                    
                    Image(systemName:"sun.max")
                    Text("Today")
                    
                }
            ForecastView()
                .tabItem{
                    Image(systemName:"cloud.sun.rain")
                    Text("Forecast")
                }
        }
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

