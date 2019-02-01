//
//  CaseDescribable.swift
//  WeatherAPI
//
//  Created by Student on 28.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

protocol CaseDescribable: CustomStringConvertible, RawRepresentable { }

extension CaseDescribable where RawValue : CustomStringConvertible {
    
    var description: String {
        return self.rawValue.description
    }
}
