//
//  RLMWeather.swift
//  WeatherAPI
//
//  Created by Student on 20.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

class RLMWeather: RLMModel {
    
    let temp = RealmOptional<Double>()
    let tempMin = RealmOptional<Double>()
    let tempMax = RealmOptional<Double>()
    let pressure = RealmOptional<Int>()
    let humidity = RealmOptional<Int>()
    let windSpeed = RealmOptional<Double>()
    let date = RealmOptional<Int>()
    
    @objc dynamic var name: String?
    
    convenience init(weather: Weather) {
        self.init()

        self.temp.value = weather.temp
        self.tempMin.value = weather.tempMin
        self.tempMax.value = weather.tempMax
        self.pressure.value = weather.pressure
        self.humidity.value = weather.humidity
        self.windSpeed.value = weather.windSpeed
        self.date.value = weather.date
        self.name = weather.name
        
        weather.name.do { self.id = $0 }
    }
}
