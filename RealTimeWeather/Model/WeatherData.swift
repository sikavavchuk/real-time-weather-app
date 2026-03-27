//
//  WeatherData.swift
//  RealTimeWeather
//
//  Created by Viktoriia Savchuk  on 27/03/2026.
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
