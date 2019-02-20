//
//  WeatherRealmDataBaseService.swift
//  WeatherAPI
//
//  Created by Student on 20.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

class WeatherRealmDataBaseServise: DataBaseServiseType {
    
    private let provider: RealmProvider<RLMWeather>
    
    init(provider: RealmProvider<RLMWeather>) {
        self.provider = provider
    }
    
    func add(object: RLMWeather) {
        self.provider.add § object
    }
    
    func read(key: String) -> RLMWeather? {
        return self.provider.read(key: key)
    }
    
    func read() -> [RLMWeather]? {
        return self.provider.read()
    }
}
