//
//  WeatherViewModel.swift
//  WeatherCl
//
//  Created by KARAN  on 09/02/22.
//

import Foundation

private let defaultIcon = "❓"
private let iconmap = [
    
    "Drizzle" : "🌧",
    "Thunderstrom" : "⛈",
    "Rain" : "🌧",
    "Snow" : "❄️",
    "Clear":"☀️",
    "Clouds":"☁️",
    "Smoke":"💨"
]
public class WeatherViewModel : ObservableObject {
    @Published var cityName : String = "city name"
    @Published var tempreature : String = "--"
    @Published var weatherDescription:String = "--"
    @Published var weatherIcon :String = defaultIcon
    
    public let weatherService : WeatherService
    
    public init(weatherService : WeatherService){
        self.weatherService = weatherService
    }
     
    public func refresh() {
        weatherService.loadWeatherData{ weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.tempreature="\(weather.tempreature)°C"
                self.weatherDescription = weather.description.capitalized
                self.weatherIcon = iconmap[weather.iconname] ?? defaultIcon
                
                
            }
        }
    }
}
