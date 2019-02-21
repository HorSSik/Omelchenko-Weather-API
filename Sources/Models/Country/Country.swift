//
//  Country.swift
//  WeatherAPI
//
//  Created by Student on 25.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Country: ObservableObject<Country.Event> {
    
    public enum Event {
        case weatherDidChange(Weather?)
    }
    
    public var weather: Weather? {
        didSet {
            self.notify(.weatherDidChange(self.weather))
        }
    }
    
    public var storageId: String {
        return "\(self.id)_\(typeString(self).lowercased())" 
    }
    
    public var id: ID
    public var name: String?
    public var capital: String?
    
    init(name: String?, capital: String?, id: ID) {
        self.name = name
        self.capital = capital
        self.id = id
    }
}
