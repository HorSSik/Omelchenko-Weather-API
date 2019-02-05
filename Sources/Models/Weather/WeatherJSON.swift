//
//  Weather.swift
//  WeatherAPI
//
//  Created by Student on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

struct WeatherJSON: Codable {
    
    struct Main: Codable {
        let temp: Double?
        let pressure: Int?
        let humidity: Int?
        let tempMin: Double?
        let tempMax: Double?
        
        enum CodingKeys: String, CodingKey {
            case temp
            case pressure
            case humidity
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
    
    struct Wind: Codable {
        let speed: Double?
        let deg: Int?
    }
    
    public let base: String
    public let main: Main
    public let visibility: Int
    public let wind: Wind
    public let dt: Int
    public let id: Int
    public let name: String
    public let cod: Int
}






