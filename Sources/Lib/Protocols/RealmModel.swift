//
//  RealmModel.swift
//  WeatherAPI
//
//  Created by Student on 21.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

protocol RealmModel {
    
    associatedtype ConvertableType: AnyObject
    
    init(object: ConvertableType)
    
    func object() -> ConvertableType?
}
