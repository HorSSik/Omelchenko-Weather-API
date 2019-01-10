//
//  PositionGenerator.swift
//  Square
//
//  Created by Student on 02.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

final class Generator<Value> {
    
    private let objects: [Value]
    private let index = Atomic(0)
    
    init(objects: [Value]) {
        self.objects = objects
    }
    
    convenience init(objects: Value...) {
        self.init(objects: objects)
    }
    
    public func next() -> Value {
        return self.index.modify { index in
            index = (index + 1) % self.objects.count
            
            return self.objects[index]
        }
    }
}
