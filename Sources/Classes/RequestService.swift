//
//  Parser.swift
//  WeatherAPI
//
//  Created by Student on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class RequestService<Value: Decodable> {
    
    public func requestData(url: URL, completion: @escaping (Value?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let information = data.flatMap { try? JSONDecoder().decode(Value.self, from: $0) }
            completion(information, error)
        }.resume()
    }
}
