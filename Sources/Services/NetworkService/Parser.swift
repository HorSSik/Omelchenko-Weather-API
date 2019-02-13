//
//  Parser.swift
//  WeatherAPI
//
//  Created by Student on 01.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public enum ParserError: Error {
    case unknown
    case jsonConvertFailure
}

class Parser {
    
    typealias ParserResult<Value> = Result<Value, ParserError>
    
    public func countries(data: Data) -> ParserResult<[Country]> {
        return self.json(from: data).mapValue(self.countries)
    }
    
    public func country(data: Data) -> ParserResult<Country> {
        return self.json(from: data).mapValue(self.country)
    }
    
    public func weather(data: Data) -> ParserResult<Weather> {
        return self.json(from: data).mapValue(self.weather)
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
    
    private func json<Value: Decodable>(from data: Data?) -> ParserResult<Value> {
        let value = data.flatMap { try? JSONDecoder().decode(Value.self, from: $0) }
        
        return Result(value: value, error: .jsonConvertFailure, default: .unknown)
    }
}
