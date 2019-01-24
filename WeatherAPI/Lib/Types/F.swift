//
//  F.swift
//  Square
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

public enum F {
    
    typealias VoidCompletion = () -> ()
    typealias Execute = () -> ()
    typealias Completion<T> = (T) -> ()
}

public func when<Result>(_ condition: Bool, execute: () -> Result?) -> Result? {
    return condition ? execute() : nil
}

public func cast<Value, Result>(_ castType: Value) -> Result? {
    return castType as? Result
}

public func toString(_ cls: AnyClass) -> String {
    return String(describing: cls)
}

func dispatchOnMain(execute: @escaping F.VoidCompletion) {
    DispatchQueue.main.async(execute: execute)
}
