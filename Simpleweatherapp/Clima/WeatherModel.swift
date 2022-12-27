//
//  AppDelegate.swift
//  Simpleweatherapp
//
//  Created by User06 on 2022/12/28.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Float
    
    var temperatureString: String{
        return String(format: "%.2f", temperature)
    }
    
    var conditionName: String {
        if 200 <= conditionId && conditionId <= 299{
            /* Group 2xx: Thunderstorm */
            return "cloud.bolt"
        } else if 300 <= conditionId && conditionId <= 399{
            /* Group 3xx: Drizzle */
            return "cloud.drizzle"
        } else if 500 <= conditionId && conditionId <= 599{
            /* Group 5xx: Rain */
            return "cloud.rain"
        } else if 600 <= conditionId && conditionId <= 699{
            /* Group 6xx: Snow */
            return "cloud.snow"
        } else if 700 <= conditionId && conditionId <= 799{
            /* Group 7xx: Atmosphere */
            return "cloud.fog"
        } else if conditionId == 800 {
            /* Group 800: Clear */
            return "sun.max"
        } else if 801 <= conditionId && conditionId <= 899{
            /* Group 80x: Clouds */
            return "cloud"
        } else {
            return "cloud"
        }
    }
}
