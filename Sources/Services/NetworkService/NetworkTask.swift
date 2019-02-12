//
//  NetworkTask.swift
//  WeatherAPI
//
//  Created by Student on 12.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class NetworkTask: Cancellable {
    
    public var isCancelled = false
    
    public private(set) var task: URLSessionTask
    
    init(task: URLSessionTask) {
        self.task = task
    }
    
    public func cancel() {
        self.task.cancel()
        self.isCancelled = true
    }
}
