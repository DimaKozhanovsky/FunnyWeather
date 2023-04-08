//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 23.04.22.
//

import SwiftUI

struct ForecastView : View {
    @StateObject var forecastViewModel = ForecastViewModel()
 var body: some View {
    //is adressed to the  @Published var state in ViewModel

        switch forecastViewModel.state {
        case .idle :
            ProgressView()
                .onAppear {
                    forecastViewModel.getDataForForecast()
                }
        case .error:
            Text("Error")
        case .recivedForecastWheather(let model):
            //declaring a value as let means that it is a constant i.e. immutable
            //you are getting the warning because instead of modifying the value as you intended, you are redeclaring it within the scope
            ForecastBodyView(model: model)
        }
        
    }
}
