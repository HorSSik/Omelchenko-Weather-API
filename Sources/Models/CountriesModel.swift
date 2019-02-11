//
//  BaseModels.swift
//  WeatherAPI
//
//  Created by Student on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class CountriesModel: ObservableObject<CountriesModel.PrepareModel> {
    
    enum PrepareModel {
        case didAppendCountry
        case didRemoveCountry
        case didRefreshCountries
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
    
    public func append(country: Country) {
        self.values.append(country)
        self.notify(.didAppendCountry)
    }
    
    public func append(countries: [Country]) {
        self.values.append(contentsOf: countries)
        self.notify(.didRefreshCountries)
    }
    
    public func remove(for index: Int) {
        self.values.remove(at: index)
        self.notify(.didRemoveCountry)
    }
}
