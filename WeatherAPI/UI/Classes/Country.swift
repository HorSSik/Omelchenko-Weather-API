//
//  Country.swift
//  WeatherAPI
//
//  Created by Student on 25.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Country {
    
    var name: String
    var capital: String
    
    init(countryJSON: CountryJSON) {
        self.name = countryJSON.name
        self.capital = countryJSON.capital
    }
}
