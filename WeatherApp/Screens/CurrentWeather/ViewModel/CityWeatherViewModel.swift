//
//  CityWeatherViewModel.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 1.05.22.
//

import Foundation

class CityWeatherViewModel: ObservableObject {
    
    @Published var model: CityWeatherModel?
    
    
    let networkService = NetworkService()
    
    func getData() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.model = CityWeatherModel(name: "NAME")
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6) {
            self.model?.name = ""
        }
        
        networkService.getData { result in
            switch result {
            case .failure(let e):
                print(e)
            case .success(let model):
                self.model = model  
            }
        }
//        { response in
//            switch response {
//
//            }
//
//        }
    }

}


