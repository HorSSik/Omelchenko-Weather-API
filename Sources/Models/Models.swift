//
//  BaseModels.swift
//  WeatherAPI
//
//  Created by Student on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Models: ObservableObject<Models.PrepareModel> {
    
    enum PrepareModel {
        
        case modelsDidAppend(Country)
        case modelsDidRemove(Country)
        case modelsRefreshed(Country)
        case modelsDeleted
    }
    
    private var values = [Country]()
    
    public var count: Int {
        return self.values.count
    }
    
    public var isEmpty: Bool {
        return self.values.isEmpty
    }
    
    subscript(index: Int) -> Wrapper<Country> {
        get {
            let wrapped = Wrapper(self.values[index])
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
        self.notify(.modelsDidAppend(country))
    }
    
    public func remove(for index: Int) {
        let removed = self.values.remove(at: index)
        self.notify(.modelsDidRemove(removed))
    }
    
    public func removeAll() {
        self.values.removeAll()
        self.notify(.modelsDeleted)
    }
    
    private func modelsRefreshed(country: Country) {
        self.notify(.modelsRefreshed(country))
    }
}
