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
    
    public var id: ID
    
    public let temp: Double?
    public let tempMin: Double?
    public let tempMax: Double?
    public let pressure: Int?
    public let humidity: Int?
    public let windSpeed: Double?
    public let date: Int?
    public let name: String?
    
    public var storageId: String {
        return "\(self.id)_\(typeString(self).lowercased())"
    }
    
    init(temp: Double?,
        tempMin: Double?,
        tempMax: Double?,
        pressure: Int?,
        humidity: Int?,
        windSpeed: Double?,
        date: Int?,
        name: String?,
        id: ID
    ) {
        self.temp = temp
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.date = date
        self.name = name
        self.id = id
    }
}

