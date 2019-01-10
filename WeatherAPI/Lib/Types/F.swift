//
//  F.swift
//  Square
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

public enum F {
    
    typealias Completion = () -> ()
    typealias Execute = () -> ()
}

public func when<Result>(_ condition: Bool, execute: () -> Result?) -> Result? {
    return condition ? execute() : nil
}

public func cast<Value, Result>(_ castType: Value) -> Result? {
    return castType as? Result
}
