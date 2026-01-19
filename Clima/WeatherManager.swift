//
//  WeatherManager.swift
//  Clima
//
//  Created by Julio Errecart on 16/1/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
    
}

struct WeatherManager {
    
    // I avoid hard-coding API keys when uploading projects to GitHub!
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=_PASTE_MY_ACTUAL_API_KEY_HERE_&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    
                    self.delegate?.didFailWithError(error: error!)
                    return
                    
                }
                
                if let safeData = data {
                    
                    if let weather = self.parseJSON(safeData) {
                        
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        
                    }
                    
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            return weather
            
        }
        catch {
            
            self.delegate?.didFailWithError(error: error)
            return nil
            
        }
        
    }
    
}
