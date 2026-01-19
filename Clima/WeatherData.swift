//
//  WeatherData.swift
//  Clima
//
//  Created by Julio Errecart on 17/1/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Decodable {
    
    let temp: Double
    
}

struct Weather: Decodable {
    
    let description: String
    let id: Int
    
}
