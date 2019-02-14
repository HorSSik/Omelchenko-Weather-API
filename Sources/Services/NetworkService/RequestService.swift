//
//  Parser.swift
//  WeatherAPI
//
//  Created by Student on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation
import Alamofire

class RequestService: RequestServiceType {

    public func requestData(
        url: URL,
        completion: @escaping (Result<Data, RequestServiceError>) -> ()
    )
        -> NetworkTask
    {
        let request = Alamofire.request(url).response { response in
            completion § Result(
                value: response.data,
                error: response.error.map(ignoreInput § returnValue § .failure),
                default: .unknown
            )
        }
        
        defer {
            request.task?.resume()
        }
        
        return request.task.map(NetworkTask.init) ?? .canceled()
    }
}
