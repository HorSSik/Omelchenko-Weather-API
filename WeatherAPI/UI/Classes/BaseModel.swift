//
//  BaseModel.swift
//  WeatherAPI
//
//  Created by Student on 18.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class BaseModel {
    
    public var weather: WeatherJSON?
    public let country: CountryJSON
    
    init(country: CountryJSON) {
        self.country = country
    }
}
