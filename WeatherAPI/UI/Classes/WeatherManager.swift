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

class WeatherManager: ObservableObject<Weather> {
    
    private var weatherModel: Weather? {
        didSet {
            self.weatherModel.do(self.notify)
        }
    }
    
    private let weatherService = RequestService<WeatherJSON>()
    
    public func getWeather(capital: String) {
        let baseUrl = Constant.mainUrl + capital + Constant.apiKey
        let convertUrl = baseUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        convertUrl
            .flatMap(URL.init)
            .do { url in
                self.weatherService.requestData(url: url) { data, error in
                    data.do { data in
                        self.weatherModel = Weather(weatherJSON: data)
                    }
                }
            }
    }
}
