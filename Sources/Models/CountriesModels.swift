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
        case modelsRefreshed
        case modelsDeleted
    }
    
    private var values = [Country]()
    
    public var count: Int {
        return self.values.count
    }
    
    public var isEmpty: Bool {
        return self.values.isEmpty
    }
    
    subscript(index: Int) -> ObservableWrapper<Country> {
        get {
            let wrapped = ObservableWrapper(self.values[index])
            wrapped.observer {
                self.modelsRefreshed(country: $0)
            }
            
            return wrapped
        }
        set {
            self.values[index] = newValue.value
            self.modelsRefreshed(country: self.values[index])
        }
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
    
    public func removeAll() {
        self.values.removeAll()
        self.notify(.modelsDeleted)
    }
    
    private func modelsRefreshed(country: Country) {
        self.notify(.modelsRefreshed)
    }
}
