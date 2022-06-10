//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 23.04.22.
//

import SwiftUI

@main //If you precede your App conformer’s declaration with the @main attribute, the system calls the conformer’s main() method to launch the app.



struct WeatherApp: App { // A type that represents the structure and behavior of an app.
    
    var body: some Scene { //A part of an app’s user interface with a life cycle managed by the system.

        
        WindowGroup { //A scene that presents a group of identically structured windows.
          
            ContentView() //Declare a view hierarchy here.
        }
        }
    }

