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
        
        case modelsDidAppend(Models?)
        case modelsDidRemove(Models?)
        case modelsRefreshed(Models?)
    }
    
    private var values = [Country]()
    
    public var count: Int {
        return self.values.count
    }
    
    subscript(index: Int) -> Wrapper<Country> {
        get {
            let wrapped = Wrapper(self.values[index])
            wrapped.observer { _ in
                self.modelsRefreshed()
            }
            
            return wrapped
        }
        set {
            self.values[index] = newValue.value
            self.modelsRefreshed()
        }
    }
    
    public func add(country: Country) {
        self.values.append(country)
        self.notify(.modelsDidAppend(self))
    }
    
    public func remove(for index: Int) {
        self.values.remove(at: index)
        self.notify(.modelsDidRemove(self))
    }
    
    private func modelsRefreshed() {
        self.notify(.modelsRefreshed(self))
    }
}
