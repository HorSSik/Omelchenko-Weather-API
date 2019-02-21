//
//  IDProvider.swift
//  WeatherAPI
//
//  Created by Student on 15.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public typealias IDProvider = () -> ID

fileprivate let persistantProviders = Atomic([String : IDProvider]())

public func autoincrementedIDStart(_ start: Int) -> IDProvider {
    return autoincrementedID(start: start, action: nil)
}

public func autoincrementedID(key: String) -> IDProvider {
    return persistantProviders.modify { storage in
        storage[key] ?? call {
            let defaults = UserDefaults.standard
            
            let result = autoincrementedID(start: defaults.integer(forKey: key)) {
                defaults.set($0, forKey: key)
            }
        
            storage[key] = result
        
            return result
        }
    }
}

typealias actionType = ((Int) -> ())?

private func autoincrementedID(start: Int, action: actionType) -> IDProvider {
    let value = Atomic(start)
    
    return {
        value.modify { value in
            let result = value
            value += 1
            action?(value)
            
            return ID(result)
        }
    }
}
