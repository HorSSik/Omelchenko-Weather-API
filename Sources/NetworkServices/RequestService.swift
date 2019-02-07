//
//  Parser.swift
//  WeatherAPI
//
//  Created by Student on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class RequestService {
    
    public func requestData(url: URL, completion: @escaping (Data?, Error?) -> ()) {
        URLSession
            .shared
            .dataTask(with: url) { (data, response, error) in
                completion(data, error)
            }
            .resume()
    }
}
