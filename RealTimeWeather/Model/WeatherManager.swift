//
//  WeatherManager.swift
//  RealTimeWeather
//
//  Created by Viktoriia Savchuk  on 26/03/2026.
//

import Foundation

struct WeatherManager {
    
    let weatherURL = ""
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session task
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            
            //4. Start the task
            task.resume()
        }
        
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
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
