//
//  Weather.swift
//  WeatherAPI
//
//  Created by Student on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    var main: [String : Double]
}
