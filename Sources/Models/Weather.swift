//
//  Weather.swift
//  WeatherAPI
//
//  Created by Student on 25.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Weather {
    
    public var emoji: Emoji? {
        return self.temp.map { $0 >= 0 ? .sun : .winter }
    }
    
    public let temp: Double?
    public let tempMin: Double?
    public let tempMax: Double?
    public let pressure: Int?
    public let humidity: Int?
    public let windSpeed: Double?
    public let date: Date?
    public let name: String?
    
    init(temp: Double?,
        tempMin: Double?,
        tempMax: Double?,
        pressure: Int?,
        humidity: Int?,
        windSpeed: Double?,
        date: Int?,
        name: String?
    ) {
        self.temp = temp
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.date = date.map { Date.init(timeIntervalSince1970: TimeInterval($0)) }
        self.name = name
    }
}

