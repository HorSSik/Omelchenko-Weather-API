//
//  DataRealmManager.swift
//  WeatherAPI
//
//  Created by Student on 18.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

class CountryRealmDataBaseServise: DataBaseServiseType {

    private let provider: RealmProvider<RLMCountry>
    
    init(provider: RealmProvider<RLMCountry>) {
        self.provider = provider
    }
    
    func add(object: RLMCountry) {
        self.provider.add § object
    }
    
    func read(key: String) -> RLMCountry? {
        return self.provider.read(key: key)
    }
    
    func read() -> [RLMCountry]? {
        return self.provider.read()
    }
}
