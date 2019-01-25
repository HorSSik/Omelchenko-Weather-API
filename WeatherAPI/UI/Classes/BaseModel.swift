//
//  BaseModel.swift
//  WeatherAPI
//
//  Created by Student on 18.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class BaseModel: ObservableObject<Any> {
    
    public var weather: Weather? 
//        didSet {
//            self.notify(State.didLoad)
//        }
    
    
    public let country: Country
    
//    public enum State {
//        case didStartLoading
//        case didLoad
//    }
    
    init(country: Country, weather: Weather? = nil) {
        self.country = country
    }
}
