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
            Text ("ВВВ")
        }
        
        Text("Helow world ")
    }
}
