//
//  AppDelegate.swift
//  Simpleweatherapp
//
//  Created by User06 on 2022/12/28.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    var delegate: WeatherManagerDelegate?
    
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    let cityName = "Keelung"
    let apiKey = "02d1521e7b6282ddaee086f8b2fde93e"
    let units = "metric"
    
    func fetchWeather(cityName: String){
        let weatherURL = "\(baseURL)?q=\(cityName)&appid=\(apiKey)&units=\(units)"
        // e.g.: api.openweathermap.org/data/2.5/weather?q=Keelung&appid=f858bfc187647d94e0866c7ddb256dfe
        //print(weatherURL)
        performRequest(urlString: weatherURL)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees){
        let weatherURL = "\(baseURL)?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=\(units)"
        performRequest(urlString: weatherURL)
    }
    
    func performRequest(urlString: String){
        // 1. Create an URL
        if let url = URL(string: urlString){
            // 2. Create an URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8)
                    //print(dataString!)
                    if let weather = self.parseJSON(safeData){
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateWeather(self, weather: weather)
                        }
                    }
                }
            }
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
            
            let cityName = decodedData.name
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: cityName, temperature: temp)
            
            print(weather.conditionName)
            
            return weather
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
