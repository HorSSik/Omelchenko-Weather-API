//
//  Wrapper.swift
//  WeatherAPI
//
//  Created by Student on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class ObservableWrapper<Value>: ObservableObject<Value> {
    
    public var value: Value
    
    init(_ value: Value) {
        self.value = value
    }
    
    public func update(action: (Value) -> ()) {
        action(self.value)
        
        self.notify(self.value)
    }
}
