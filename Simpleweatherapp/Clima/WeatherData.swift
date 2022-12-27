//
//  AppDelegate.swift
//  Simpleweatherapp
//
//  Created by User06 on 2022/12/28.
//

import Foundation

struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Float
}

struct Weather: Codable {
    let id: Int
    let description: String
}
