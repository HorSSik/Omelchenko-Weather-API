//
//  Parser.swift
//  WeatherAPI
//
//  Created by Student on 01.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Parser {
    
    public func countries(data: Data?) -> [Country]? {
        return self.json(data: data)
            .map(self.countries)
    }
    
    public func country(data: Data?) -> Country? {
        return self.json(data: data)
            .map(self.country)
    }
    
    public func weather(data: Data?) -> Weather? {
        return self.json(data: data)
            .map(self.weather)
    }
    
    private func countries(json: [CountryJSON]) -> [Country] {
        return json
            .filter { !$0.capital.isEmpty }
            .map(self.country)
    }
    
    private func country(json: CountryJSON) -> Country {
        return Country(name: json.name, capital: json.capital)
    }
    
    private func weather(json: WeatherJSON) -> Weather {
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
    
    private func json<Value: Decodable>(data: Data?) -> Value? {
        return data.flatMap { try? JSONDecoder().decode(Value.self, from: $0) }
    }
}
