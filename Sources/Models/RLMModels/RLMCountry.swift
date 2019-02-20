//
//  RLMCountries.swift
//  WeatherAPI
//
//  Created by Student on 18.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

class RLMCountry: RLMModel {
    
    @objc dynamic var name: String?
    @objc dynamic var capital: String?
    
    convenience init(country: Country) {
        self.init()
        
        let capital = country.capital
        
        self.name = country.name
        self.capital = capital
        capital.do { self.id = $0 }
    }
}

