//
//  RequestServiceType.swift
//  WeatherAPI
//
//  Created by Student on 11.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation
import Alamofire

public enum RequestServiceError: Error {
    case unknown
    case failure
}

protocol RequestServiceType {
    
    func requestData(url: URL, completion: @escaping (Result<Data, RequestServiceError>) -> ()) -> NetworkTask
}
