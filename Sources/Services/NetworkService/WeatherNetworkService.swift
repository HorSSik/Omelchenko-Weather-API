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

class WeatherNetworkService: Cancellable, StateableNetwork {
    
    public var isCancelled: Bool {
        return self.requestService.isCancelled
    }
    
    public var status = NetworkState.idle
    
    private let parser = Parser()
    private let requestService: RequestServiceType
    
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
                self.status = .inLoad
                self.requestService.requestData(url: url) { data, error in
                    country.weather = self.parser.weather(data: data)
                    self.status = .didLoad
                }
            }
    }
    
    public func cancel() {
        self.requestService.cancel()
        self.status = .cancelled
    }
}
