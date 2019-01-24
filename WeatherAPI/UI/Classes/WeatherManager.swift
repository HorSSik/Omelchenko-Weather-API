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

class WeatherManager {
    
    public var completion: F.Completion<WeatherJSON>?
    
    private(set) var weatherInfo: WeatherJSON?
    
    private let parserWeather = NetworkManager<WeatherJSON>()
    
    init() {
        self.subscribe()
    }
    
    public func getWeather(capital: String) {
        let baseUrl = Constant.mainUrl + capital + Constant.apiKey
        let convertUrl = baseUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        convertUrl
            .flatMap(URL.init)
            .do(self.parserWeather.requestData)
    }
    
    private func subscribe() {
        _ = self.parserWeather.observer { state in
            switch state {
            case .didStartLoading: return
            case .didLoad:
                self.parserWeather.model.do { weather in
                    self.weatherInfo = weather
                    
                    self.completion?(weather)
                }
            case .didFailedWithError: return
            }
        }
    }
}
