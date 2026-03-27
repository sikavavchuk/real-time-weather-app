//
//  WeatherManager.swift
//  RealTimeWeather
//
//  Created by Viktoriia Savchuk  on 26/03/2026.
//

import Foundation

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=19cf2e4a02d4c8d7870c7cda15429d72&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            //4. Start the task
            task.resume()
        }

        
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let name = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let description = decodedData.weather[0].description
            
            let weather = WeatherModel(cityName: name, temperature: temp, weatherId: id, weatherDescription: description)
            
            print(weather.temperatureString)
            
            
        } catch {
            print(error)
        }
        
    }
    
}
