//
//  Weather.swift
//  WeatherCl
//
//  Created by KARAN  on 09/02/22.
//

import Foundation

public struct Weather {
    let city : String
    let tempreature : String
    let description : String
    let iconname : String
    
    init(response : ApiResponse){
        city = response.name
        tempreature = "\(Int(response.main.temp))"
        description = response.weather.first?.description ?? ""
        iconname = response.weather.first?.iconname ?? ""
        
    }
}
