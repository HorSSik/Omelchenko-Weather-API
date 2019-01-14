//
//  Countries.swift
//  WeatherAPI
//
//  Created by Student on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

struct Countries: Decodable {
    var countries = [Country]()
}

struct Country: Decodable {
    var name: String
    var capital: String
}
