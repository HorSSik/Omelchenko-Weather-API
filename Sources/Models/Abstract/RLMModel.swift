//
//  RLMModel.swift
//  WeatherAPI
//
//  Created by Student on 14.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

public class RLMModel: Object {
    
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var id = ""
}
