//
//  WeatherData.swift
//  WeatherAPI
//
//  Created by Student on 16.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

fileprivate struct Constant {
    static let mainUrl = "https://api.openweathermap.org/data/2.5/weather?q="
    static let apiKey = "&units=metric&APPID=60cf95f166563b524e17c7573b54d7e3"
}

class WeatherData {
    
    private(set) var temperature = 0
    private(set) var maxTemperature = 0
    private(set) var minTemperature = 0
    private(set) var city = "Default"
    private(set) var emoji = Emoji.sun.rawValue
    private(set) var humidity = 0
    private(set) var wind = 0.0
    private(set) var pressure = 0
    
    private let weatherController = WeatherViewController()
    private let parserWeather = Parser<Weather>()
    
    public func parsWeather(capital: String, completion: @escaping (UIViewController) -> ()) {
        let baseUrl = Constant.mainUrl + capital + Constant.apiKey
        let convertUrl = baseUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        convertUrl.do { if let url = URL(string: $0) { parserWeather.requestData(url: url) } }
        
        _ = parserWeather.observer { state in
            switch state {
            case .notWorking: return
            case .didStartLoading: return
            case .didLoad:
                self.parserWeather.model.do { weather in
                    let main = weather.main
                    
                    main["temp"].do { self.temperature = Int($0) }
                    main["temp_min"].do { self.minTemperature = Int($0) }
                    main["temp_max"].do { self.maxTemperature = Int($0) }
                    main["humidity"].do { self.humidity = Int($0) }
                    main["pressure"].do { self.pressure = Int($0) }
                    weather.wind["speed"].do { self.wind = $0 }
                }
                let stateWeather = self.temperature >= 0 ? Emoji.sun.rawValue : Emoji.winter.rawValue
                
                self.city = capital.uppercased()
                self.emoji = stateWeather
                self.weatherController.weatherData = self
                completion(self.weatherController)
            case .didFailedWithError: return
            }
        }
    }
}
