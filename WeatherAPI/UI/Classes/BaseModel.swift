//
//  BaseModel.swift
//  WeatherAPI
//
//  Created by Student on 18.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class BaseModel {
    
    public var weather: Weather?
    
    public let country: Country
    
    init(country: Country, weather: Weather? = nil) {
        self.country = country
    }
}
