//
//  Parser.swift
//  WeatherAPI
//
//  Created by Student on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class RequestService: RequestServiceType {

    public private(set) var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    public func requestData(
        url: URL,
        completion: @escaping (Result<Data, RequestServiceError>) -> ()
    )
        -> NetworkTask
    {
        let task = self.session.dataTask(with: url) { (data, response, error) in
            completion § Result(
                value: data,
                error: error.map(ignoreInput § returnValue § .failure),
                default: .unknown
            )
        }
        
        defer {
            task.resume()
        }
        
        return NetworkTask(task: task)
    }
}
