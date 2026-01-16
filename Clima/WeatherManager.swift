//
//  WeatherManager.swift
//  Clima
//
//  Created by Julio Errecart on 16/1/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    // I avoid hard-coding API keys when uploading projects to GitHub!
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=_PASTE_MY_ACTUAL_API_KEY_HERE_&units=metric"
    
    func fetchWeather(cityName: String) {
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        
    }
    
}
