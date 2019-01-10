//
//  DispatchQueue+Extension.swift
//  Square
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    static var userInteractive = DispatchQueue.global(qos: .userInteractive)
    static var userInitiated = DispatchQueue.global(qos: .userInitiated)
    static var unspecified = DispatchQueue.global(qos: .unspecified)
    static var background = DispatchQueue.global(qos: .background)
    static var `default` = DispatchQueue.global(qos: .default)
    static var utility = DispatchQueue.global(qos: .utility)
}
