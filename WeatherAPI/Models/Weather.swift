//
//  Weather.swift
//  WeatherAPI
//
//  Created by Student on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

struct Weather: Codable {
    
    struct Clouds: Codable {
        let all: Int
    }
    
    struct Coord: Codable {
        let lon, lat: Double
    }
    
    struct Main: Codable {
        let temp: Double
        let pressure, humidity: Int
        let tempMin, tempMax: Double
        
        enum CodingKeys: String, CodingKey {
            case temp, pressure, humidity
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
    
    struct Sys: Codable {
        let type, id: Int
        let message: Double
        let country: String
        let sunrise, sunset: Int
    }
    
    struct WeatherInfo: Codable {
        let id: Int
        let main, description, icon: String
    }
    
    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }
    
    public let coord: Coord
    public let weather: [WeatherInfo]
    public let base: String
    public let main: Main
    public let visibility: Int
    public let wind: Wind
    public let clouds: Clouds
    public let dt: Int
    public let sys: Sys
    public let id: Int
    public let name: String
    public let cod: Int
    
    public var emoji: Emoji {
        return self.main.temp >= 0 ? .sun : .winter
    }
}






