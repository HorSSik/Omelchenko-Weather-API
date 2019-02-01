//
//  Wrapper.swift
//  WeatherAPI
//
//  Created by Student on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Wrapper<Value>: ObservableObject<Value> {
    
    public var value: Value {
        didSet {
            self.notify(self.value)
        }
    }
    
    init(_ value: Value) {
        self.value = value
    }
    
    public func update(completion: (Value) -> ()) {
        completion(self.value)
        
        self.notify(self.value)
    }
}
