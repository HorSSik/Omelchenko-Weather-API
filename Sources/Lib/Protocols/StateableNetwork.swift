//
//  StatableNetwork.swift
//  WeatherAPI
//
//  Created by Student on 11.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

enum NetworkState {
    case inLoad
    case didLoad
    case cancelled
    case idle
}

protocol StateableNetwork {
    var status: NetworkState { get }
}
