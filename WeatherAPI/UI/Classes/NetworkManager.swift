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
    
    private(set) var model: Value?
    
    public func requestData(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let information = data.flatMap { try? JSONDecoder().decode(Value.self, from: $0) }
            information.do {
                self.model = $0
                self.notify(.didLoad)
            }
            error.do {
                self.notify(.didFailedWithError($0))
            }
        }.resume()
    }
}
