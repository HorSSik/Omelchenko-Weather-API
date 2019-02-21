//
//  RLMWeather.swift
//  WeatherAPI
//
//  Created by Student on 20.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

class RLMWeather: RLMModel, RealmModel {
    
    typealias ConvertableType = Weather
    
    var temp = RealmOptional<Double>()
    var tempMin = RealmOptional<Double>()
    var tempMax = RealmOptional<Double>()
    var pressure = RealmOptional<Int>()
    var humidity = RealmOptional<Int>()
    var windSpeed = RealmOptional<Double>()
    var date = RealmOptional<Int>()
    
    @objc dynamic var name: String?
    
    required convenience init(object weather: ConvertableType) {
        self.init()

        self.temp.value = weather.temp
        self.tempMin.value = weather.tempMin
        self.tempMax.value = weather.tempMax
        self.pressure.value = weather.pressure
        self.humidity.value = weather.humidity
        self.windSpeed.value = weather.windSpeed
        self.date.value = weather.date
        self.name = weather.name
        self.id = weather.storageId 
    }
    
    public func object() -> Weather? {
        return self.convertedID(self.id).map {
            Weather(
                temp: self.temp.value,
                tempMin: self.tempMin.value,
                tempMax: self.tempMax.value,
                pressure: self.pressure.value,
                humidity: self.humidity.value,
                windSpeed: self.windSpeed.value,
                date: self.date.value,
                name: self.name,
                id: $0
            )
        }
    }
}
