//
//  Data+Extensions.swift
//  WeatherAPI
//
//  Created by Student on 21.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

extension Date {
    
    public var shortDescription: String {
        return DateFormatter().short.string(from: self)
    }
}
