//
//  RLMCountries.swift
//  WeatherAPI
//
//  Created by Student on 18.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

class RLMCountry: RLMModel, RealmModel {
    
    typealias ConvertableType = Country
    
    @objc dynamic var name: String?
    @objc dynamic var capital: String?
    
    @objc dynamic var weather: RLMWeather?
    
    required convenience init(object country: ConvertableType) {
        self.init()
    
        self.name = country.name
        self.capital = country.capital
        self.weather = country.weather.map(RLMWeather.init)
        self.id = country.storageId 
    }
    
    func object() -> Country? {
        return self.convertedID(self.id).map {
            Country(
                name: self.name,
                capital: self.capital,
                id: $0
            )
        }
    }
}

