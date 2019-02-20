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

class WeatherNetworkService<DataBaseServise: DataBaseServiseType>
    where DataBaseServise.Model == RLMWeather
{
    
    private let parser = Parser()
    private let requestService: RequestServiceType
    private let dataBaseService: DataBaseServise
    
    init(requestService: RequestServiceType, dataBaseService: DataBaseServise) {
        self.requestService = requestService
        self.dataBaseService = dataBaseService
    }
    
    public func getWeather(country: Country) -> NetworkTask {
        let convertUrl = country.capital?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let baseUrl = convertUrl.map { Constant.mainUrl + $0 + Constant.apiKey }
        
        return baseUrl
            .flatMap(URL.init)
            .map { url in
                self.requestService.requestData(url: url) { result in
                    result.analisys(
                        success: {
                            let weather = self.parser.weather(data: $0)
                            weather.analisys(
                                success: {
                                    country.weather = $0
                                    self.dataBaseService.add § RLMWeather.init § $0
                                },
                                failure: {
                                    let weatherRLM = country.capital.flatMap {
                                        self.dataBaseService.read(key: $0)
                                    }
                                    country.weather = self.parser.weather(RLMWeather: weatherRLM)
                                    print($0.localizedDescription)
                                }
                            )
                        },
                        failure: {
                            print($0.localizedDescription)
                        }
                    )
                }
            }
            ?? .canceled()
    }
}
