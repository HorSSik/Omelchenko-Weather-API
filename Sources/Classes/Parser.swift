//
//  Parser.swift
//  WeatherAPI
//
//  Created by Student on 01.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Parser {
    
    public func filledCountries(countryJSON: CountryJSON) -> Country {
        return Country(name: countryJSON.name, capital: countryJSON.capital)
    }
    
    public func filledWeather(weatherJSON: WeatherJSON) -> Weather {
        let main = weatherJSON.main
        let wind = weatherJSON.wind.speed
        
        return Weather(
            temp: main.temp,
            tempMin: main.tempMin,
            tempMax: main.tempMax,
            pressure: main.pressure,
            humidity: main.humidity,
            windSpeed: wind,
            date: weatherJSON.dt,
            name: weatherJSON.name
        )
    }
}
