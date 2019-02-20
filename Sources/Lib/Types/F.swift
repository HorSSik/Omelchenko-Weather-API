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
    typealias Action<T> = () -> (T)
}

public func when<Result>(_ condition: Bool, execute: () -> Result?) -> Result? {
    return condition ? execute() : nil
}

public func cast<Value, Result>(_ castType: Value) -> Result? {
    return castType as? Result
}

public func sideEffect<Value>(_ action: @escaping (Value) -> ()) -> (Value) -> Value {
    return {
        action($0)
        
        return $0
    }
}

public func call<Value>(_ action: () -> Value) -> Value {
    return action()
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

public func modify<Value>(_ value: Value, action: (inout Value) -> ()) -> Value {
    var result = value
    action(&result)
    
    return result
}

public func typeString<T>(_ type: T.Type) -> String {
    return String(describing: type)
}

public func typeString<T>(_ value: T) -> String {
    return typeString § type(of: value)
}
