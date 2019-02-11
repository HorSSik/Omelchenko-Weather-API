//
//  Parser.swift
//  WeatherAPI
//
//  Created by Student on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class RequestService: RequestServiceType, Cancellable {
    
    public var isCancelled: Bool {
        get {
            return self.cancelled
        }
    }
    
    private var cancelled = false
    
    private(set) var task: URLSessionTask?
    
    public func requestData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        var task = self.task
        
        task = URLSession
            .shared
            .dataTask(with: url) { (data, response, error) in
                completion(data, response, error)
            }
        
        task?.resume()
        
        self.task = task
    }
    
    public func cancel() {
        self.cancelled = true
        self.task?.cancel()
        self.task = nil
    }
}
