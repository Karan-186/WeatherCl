//
//  WeatherClApp.swift
//  WeatherCl
//
//  Created by KARAN  on 09/02/22.
//

import SwiftUI

@main
struct WeatherClApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
            let viewModel = WeatherViewModel(weatherService : weatherService)
            WeatherView(viewModel: viewModel)
            
        }
    }
}
