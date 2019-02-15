//
//  WeakBox.swift
//  WeatherAPI
//
//  Created by Student on 14.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public struct WeakBox<Wrapped: AnyObject> {
    
    public var isEmpty: Bool {
        return self.wrapped == nil
    }
    
    public private(set) var wrapped: Wrapped?
    
    init(_ wrapped: Wrapped?) {
        self.wrapped = wrapped
    }
}

extension WeakBox: Equatable {
    
    public static func == (lhs: WeakBox<Wrapped>, rhs: WeakBox<Wrapped>) -> Bool {
        return lhs
            .wrapped.flatMap { lhs in
                rhs.wrapped.map {
                    $0 === lhs
                }
            }
            ?? false
    }
}
