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
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String) {
        
        // 1. Create a URL
        if let url = URL(string: urlString) {
            
            // 2. Create a URL Session
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            // 4. Start the task
            task.resume()
            
        }
        
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
        
        if error != nil {
            
            print(error!)
            return
            
        }
        
        if let safeData = data {
            
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString!)
            
        }
        
    }
    
}
