//
//  Parser.swift
//  WeatherAPI
//
//  Created by Student on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class RequestService: RequestServiceType, Cancellable {
    
    enum RequestServicesEvent {
        case inLoad
        case didLoad
        case cancelled
        case idle
    }
    
    public var isCancelled: Bool {
        get {
            return self.status == .cancelled ? true : false
        }
    }
    
    public var status = RequestServicesEvent.idle
    
    private(set) var task: URLSessionTask?
    
    public func requestData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        var task = self.task
        
        self.status = .inLoad
        task = URLSession
            .shared
            .dataTask(with: url) { (data, response, error) in
                self.status = .didLoad
                completion(data, response, error)
            }
        
        task?.resume()
    }
    
    public func cancel() {
        self.status = .cancelled
        self.task = nil
    }
}
