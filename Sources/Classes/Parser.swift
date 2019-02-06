//
//  Parser.swift
//  WeatherAPI
//
//  Created by Student on 01.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Parser {
    
    public func countries(json: [CountryJSON]) -> [Country] {
        return json
            .filter {
                !$0.capital.isEmpty
            }
            .map {
                self.country(json: $0)
            }
    }
    
    public func country(json: CountryJSON) -> Country {
        return Country(name: json.name, capital: json.capital)
    }
    
    public func weather(json: WeatherJSON) -> Weather {
        let main = json.main
        let wind = json.wind.speed
        
        return Weather(
            temp: main.temp,
            tempMin: main.tempMin,
            tempMax: main.tempMax,
            pressure: main.pressure,
            humidity: main.humidity,
            windSpeed: wind,
            date: json.dt,
            name: json.name
        )
    }
}
