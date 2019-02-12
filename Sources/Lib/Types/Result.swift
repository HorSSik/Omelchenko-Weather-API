//
//  Result.swift
//  WeatherAPI
//
//  Created by Student on 12.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
    
    public var value: Value? {
        return self.analisys(
            success: identity,
            failure: ignoreInput § returnValue § nil
        )
    }
    
    public var error: Error? {
        return self.analisys(
            success: ignoreInput § returnValue § nil,
            failure: identity
        )
    }
    
    public init(value: Value?, error: Error?, `default`: Error) {
        self = value.map(lift)
            ?? error.map(lift)
            ?? .failure(`default`)
    }
    
    public func analisys<ReturnType>(
        success: (Value) -> ReturnType,
        failure: (Error) -> ReturnType
    )
        -> ReturnType
    {
        switch self {
        case let .success(wrapped): return success(wrapped)
        case let .failure(wrapped): return failure(wrapped)
        }
    }
    
    public func bimap<NewValue, NewError>(
        success: (Value) -> NewValue,
        failure: (Error) -> NewError
    )
        -> Result<NewValue, NewError>
    {
        return withoutActuallyEscaping(success) { success in
            withoutActuallyEscaping(failure) { failure in
                self.analisys(success: success • lift, failure: failure • lift)
            }
        }
    }
    
    public func mapValue<NewValue>(_ transform: (Value) -> NewValue) -> Result<NewValue, Error> {
        return self.bimap(success: transform, failure: identity)
    }
    
    public func mapError<NewError>(_ transform: (Error) -> NewError) -> Result<Value, NewError> {
        return self.bimap(success: identity, failure: transform)
    }
    
    public func biflatMap(
        success: (Value) -> Result,
        failure: (Error) -> Result
    )
        -> Result
    {
        return self.analisys(success: success, failure: failure)
    }
    
    public func flatMapValue(_ transform: (Value) -> Result) -> Result {
        return self.biflatMap(success: transform, failure: lift)
    }
    
    public func flatMapError(_ transform: (Error) -> Result) -> Result {
        return self.biflatMap(success: lift, failure: transform)
    }
}

fileprivate func lift<Value, Error: Swift.Error>(_ value: Value) -> Result<Value, Error> {
    return .success(value)
}

fileprivate func lift<Value, Error: Swift.Error>(_ error: Error) -> Result<Value, Error> {
    return  .failure(error)
}
