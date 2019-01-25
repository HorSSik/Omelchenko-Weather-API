//
//  Parser.swift
//  WeatherAPI
//
//  Created by Student on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class NetworkManager<Value>: ObservableObject<NetworkManager.State> where Value: Decodable {
    
    public enum State {
        case didStartLoading
        case didLoad
        case didFailedWithError(_ error: Error?)
    }
    
    public func requestData(url: URL, completion: @escaping (Value?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let information = data.flatMap { try? JSONDecoder().decode(Value.self, from: $0) }
            
            var dataBack: Value?
            var errorBack: Error?
            
            information.do { information in
                dataBack = information
//                self.notify(.didLoad)
            }
            error.do {
                errorBack = $0
//                self.notify(.didFailedWithError($0))
            }
            completion(dataBack, errorBack)
        }.resume()
    }
}
