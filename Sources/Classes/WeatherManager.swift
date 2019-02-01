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
    
    private let requestService: RequestService<WeatherJSON>
    
    private let parser = Parser()
    
    init(requestService: RequestService<WeatherJSON>) {
        self.requestService = requestService
    }
    
    public func getWeather(country: Wrapper<Country>) {
        let capital = country.value.capital
        let baseUrl = Constant.mainUrl + capital + Constant.apiKey
        let convertUrl = baseUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        convertUrl
            .flatMap(URL.init)
            .do { url in
                self.requestService.requestData(url: url) { data, error in
                    data.do { data in
                        country.update {
                            $0.weather = self.parser.filledWeather(weatherJSON: data)
                        }
                    }
                }
            }
    }
}
