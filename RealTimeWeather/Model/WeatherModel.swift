//
//  WeatherModel.swift
//  RealTimeWeather
//
//  Created by Viktoriia Savchuk  on 27/03/2026.
//

import Foundation

struct WeatherModel {
    
    let cityName: String
    let temperature: Double
    let weatherId: Int
    let weatherDescription: String
    
    var temperatureString: String {
        return String(format: "%.1f°C", temperature)
    }
    
    var conditionName: String {
        switch weatherId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
    
    var conditionBackground: String {
        switch conditionName {
        case "sun.max":
            return "sunny-weather"
        default:
            return "cloudy-weather"
        }
    }
}
