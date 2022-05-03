//
//  Today.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 23.04.22.
//

import SwiftUI

struct TodayView: View {
    
    @StateObject var cityWeatherViewModel = CityWeatherViewModel()
    
    var body: some View {
        switch cityWeatherViewModel.state {
            
        case .idle:
            ProgressView()
                .onAppear {
                    cityWeatherViewModel.getData()
                }
            
        case .error:
            Text("Error")
            
        case .success(let model):
            TodayBodyView(model: model)
        }
        
    }
}

struct Today_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
