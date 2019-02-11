//
//  RequestServiceType.swift
//  WeatherAPI
//
//  Created by Student on 11.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

protocol RequestServiceType {
    
    var task: URLSessionTask? { get }
    
    func requestData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}
