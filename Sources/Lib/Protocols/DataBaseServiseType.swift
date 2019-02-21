//
//  DataBaseServiseType.swift
//  WeatherAPI
//
//  Created by Student on 19.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

protocol DataBaseServiseType {
    
    associatedtype Model: AnyObject
    
    func add(object: Model)
    
    func read(id: ID) -> Model?
    
    func read() -> [Model]?
}
