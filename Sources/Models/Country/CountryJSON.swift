//
//  Countries.swift
//  WeatherAPI
//
//  Created by Student on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

struct CountryJSON: Decodable {
    
    public let name: String
    public let capital: String
}
