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

func side<Value>(value: Value, f: (Value) -> ()) -> Value {
    let muttableValue = value
    f(muttableValue)
    
    return muttableValue
}

public func identity<Value>(_ value: Value) -> Value {
    return value
}

public func ignoreInput<Value, Result>(_ action: @escaping () -> Result) -> (Value) -> (Result) {
    return { _ in
        action()
    }
}

public func returnValue<Value>(_ value: Value) -> () -> Value {
    return { value }
}

public func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in
        { f(a, $0) }
    }
}

public func uncurry<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (A, B) -> C {
    return { f($0)($1) }
}

public func flip<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
    return { b in { a in f(a)(b) } }
}

public func flip<A, B, C>(_ f: @escaping (A, B) -> C) -> (B, A) -> C {
    return { f($1, $0) }
}

public func toString(_ cls: AnyClass) -> String {
    return String(describing: cls)
}

func performOnMain(_ execute: @escaping F.VoidCompletion) {
    DispatchQueue.main.async(execute: execute)
}

func stringWithUnit(value: CustomStringConvertible?, unit: Unit) -> String {
    return "\(value ?? "")\(unit)"
}

func stringWithDegrees(value: CustomStringConvertible?) -> String {
    return stringWithUnit(value: value, unit: .degrees)
}
