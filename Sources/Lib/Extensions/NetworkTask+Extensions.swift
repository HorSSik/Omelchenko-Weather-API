//
//  NetworkTask+Extensions.swift
//  WeatherAPI
//
//  Created by Student on 12.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

extension NetworkTask {
    
    class func canceled() -> NetworkTask {
        let task = NetworkTask(task: .init())
        task.isCancelled = true
        
        return task
    }
}
