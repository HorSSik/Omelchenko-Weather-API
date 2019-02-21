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
    where DataBaseServise.Model == Weather
{
    private let requestService: RequestServiceType
    private let dataBaseService: DataBaseServise
    private let parser: Parser
    
    init(requestService: RequestServiceType, dataBaseService: DataBaseServise, parser: Parser) {
        self.requestService = requestService
        self.dataBaseService = dataBaseService
        self.parser = parser
    }
    
    public func getWeather(country: Country) -> NetworkTask {
        let convertUrl = country.capital?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let baseUrl = convertUrl.map { Constant.mainUrl + $0 + Constant.apiKey }
        
        return baseUrl
            .flatMap(URL.init)
            .map { url in
                self.requestService.requestData(url: url) { result in
                    result.analisys(
                        success: { data in
                            let weather = self.parser.weather(data: data, id: country.id)
                            weather.analisys(
                                success: { weather in
                                    country.weather = weather
                                    self.dataBaseService.add § weather
                                },
                                failure: {
//                                    country.weather = country.id.flatMap { self.dataBaseService.read(id: $0) }
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
