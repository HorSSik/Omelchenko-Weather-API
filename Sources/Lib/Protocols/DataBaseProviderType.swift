//
//  DataBaseProviderType.swift
//  WeatherAPI
//
//  Created by Student on 19.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

protocol DataBaseProviderType {
    
    associatedtype DataBaseObject: AnyObject
    
    func add(object: DataBaseObject)
    
    func read(key: String) -> DataBaseObject?
    
    func read() -> [DataBaseObject]?
}
