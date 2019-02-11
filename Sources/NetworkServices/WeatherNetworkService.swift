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

class WeatherNetworkService: Cancellable {
    
    public var isCancelled: Bool {
        get {
            return self.requestService.isCancelled
        }
    }
    
    private let requestService: RequestServiceType
    
    private let parser = Parser()
    
    init(requestService: RequestServiceType) {
        self.requestService = requestService
    }
    
    public func getWeather(country: Country) {
        let capital = country.capital
        let convertUrl = capital.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let baseUrl = convertUrl.map { Constant.mainUrl + $0 + Constant.apiKey}
        
        baseUrl
            .flatMap(URL.init)
            .do { url in
                self.requestService.requestData(url: url) { data, response, error in
                    country.weather = self.parser.weather(data: data)
                }
            }
    }
    
    public func cancel() {
        self.requestService.cancel()
    }
}
