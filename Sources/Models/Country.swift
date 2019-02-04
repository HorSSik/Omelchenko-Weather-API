//
//  Country.swift
//  WeatherAPI
//
//  Created by Student on 25.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Country {
    
    public var weather: Weather?
    
    public let name: String
    public let capital: String
    
    init(name: String, capital: String) {
        self.name = name
        self.capital = capital
    }
}
