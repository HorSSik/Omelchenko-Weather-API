//
//  BaseModels.swift
//  WeatherAPI
//
//  Created by Student on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class CountriesModels: ObservableObject<CountriesModels.PrepareModel> {
    
    enum PrepareModel {
        
        case modelsDidAppend
        case modelsDidRemove
    }
    
    private var values = [Country]()
    
    public var count: Int {
        return self.values.count
    }
    
    public var isEmpty: Bool {
        return self.values.isEmpty
    }
    
    subscript(index: Int) -> Country {
        return self.values[index]
    }
    
    public func add(country: Country) {
        self.values.append(country)
        self.notify(.modelsDidAppend)
    }
    
    public func add(countries: [Country]) {
        self.values = countries
        self.notify(.modelsDidAppend)
    }
    
    public func remove(for index: Int) {
        self.values.remove(at: index)
        self.notify(.modelsDidRemove)
    }
}
