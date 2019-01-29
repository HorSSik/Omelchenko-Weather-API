//
//  BaseModel.swift
//  WeatherAPI
//
//  Created by Student on 18.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class BaseModel: ObservableObject<BaseModel.PrepareBaseModel> {
    
    enum PrepareBaseModel {
        
        case weatherLoad(Weather?)
        case countryLoad(Country?)
    }
    
    public var weather: Wrapper<Weather?>
    
    public let country: Wrapper<Country>
    
    init(country: Country, weather: Weather? = nil) {
        self.country = Wrapper(country)
        self.weather = Wrapper(weather)
        
        super.init()
        
        self.subscribe()
    }
    
    convenience init(country: Country) {
        self.init(country: country, weather: nil)
    }
    
    private func subscribe() {
        _ = self.country.observer { country in
            self.notify(.countryLoad(country))
        }
        
        _ = self.weather.observer { weather in
            self.notify(.weatherLoad(weather))
        }
    }
}
