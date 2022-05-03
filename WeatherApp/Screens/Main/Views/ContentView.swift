//
//  ContentView.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 23.04.22.
//

import SwiftUI



struct ContentView: View {
    
    var body: some View {
        
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

