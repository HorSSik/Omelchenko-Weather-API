//
//  Weather.swift
//  WeatherAPI
//
//  Created by Student on 25.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Weather {
    
    var temp: Double?
    var tempMin: Double?
    var tempMax: Double?
    var pressure: Int?
    var humidity: Int?
    var windSpeed: Double?
    var dt: Int?
    var name: String?
    
    public var emoji: Emoji? {
        return self.temp.map { $0 >= 0 ? .sun : .winter }
    }
    
    init(weatherJSON: WeatherJSON) {
        let main = weatherJSON.main
        
        self.temp = main.temp
        self.tempMin = main.tempMin
        self.tempMax = main.tempMax
        self.pressure = main.pressure
        self.humidity = main.humidity
        self.windSpeed = weatherJSON.wind.speed
        self.dt = weatherJSON.dt
        self.name = weatherJSON.name
    }
}

