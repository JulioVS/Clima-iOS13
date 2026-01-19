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
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    
                    print(error!)
                    return
                    
                }
                
                if let safeData = data {
                    
                    parseJSON(weatherData: safeData)
                    
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
    func parseJSON(weatherData: Data) {
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)

            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp

            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            print(weather)
            print(weather.conditionName)
            print(weather.temperatureString)

        }
        catch {
            
            print(error)
            
        }
        
    }
    
}
