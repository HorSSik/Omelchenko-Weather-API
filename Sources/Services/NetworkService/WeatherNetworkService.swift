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

class WeatherNetworkService {
    
    private let parser = Parser()
    private let requestService: RequestServiceType
    
    init(requestService: RequestServiceType) {
        self.requestService = requestService
    }
    
    public func getWeather(country: Country) -> NetworkTask {
        let convertUrl = country.capital.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let baseUrl = convertUrl.map { Constant.mainUrl + $0 + Constant.apiKey }
        
        return baseUrl
            .flatMap(URL.init)
            .map { url in
                self.requestService.requestData(url: url) { result in
                    result.analisys(
                        success: {
                            let weather = self.parser.weather(data: $0)
                            weather.mapValue {
                                country.weather = $0
                            }
                        },
                        failure: {
                            print($0.localizedDescription)
                        }
                    )
                }
            } ?? .canceled()
    }
}
