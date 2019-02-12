//
//  Parser.swift
//  WeatherAPI
//
//  Created by Student on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public enum RequestServiceError {
    case unknown
    case failure
}

class RequestService: RequestServiceType, Cancellable {
    
    public var isCancelled: Bool {
        return self.cancelled
    }
    
    private var cancelled = false
    
    private(set) var task: URLSessionTask?
    
    public func requestData(url: URL, completion: @escaping (Data?, Error?) -> ()) {
        self.task = URLSession
            .shared
            .dataTask(with: url) { (data, response, error) in
                completion(data, error)
            }
        
        self.task?.resume()
    }
    
    public func cancel() {
        self.cancelled = true
        self.task?.cancel()
        self.task = nil
    }
}
