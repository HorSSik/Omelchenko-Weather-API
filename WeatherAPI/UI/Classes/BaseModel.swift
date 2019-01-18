//
//  BaseModel.swift
//  WeatherAPI
//
//  Created by Student on 18.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class BaseModel {
    
    public var country: Country?
    public var weather: Weather?
    
    init(country: Country) {
        self.country = country
    }
}

class Model {
    
    public var value = [BaseModel]()
    
    init(value: [BaseModel]) {
        self.value = value
    }
}
