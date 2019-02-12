//
//  CountriesManager.swift
//  WeatherAPI
//
//  Created by Student on 17.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

fileprivate struct Constant {
    static let mainUrl = "https://restcountries.eu/rest/v2/all"
}

class CountriesNetworkService: Cancellable, StateableNetwork {
    
    public var isCancelled: Bool {
        return self.requestService.isCancelled
    }
    
    public var status = NetworkState.idle
    
    private let parser = Parser()
    private let requestService: RequestServiceType
    
    init(requestService: RequestServiceType) {
        self.requestService = requestService
    }
    
    public func getCountries(models: CountriesModel) {
        let urlCountry = URL(string: Constant.mainUrl)
        
        urlCountry.do { url in
            self.status = .inLoad
            self.requestService.requestData(url: url) { data, error in
                let countries = self.parser.countries(data: data)
                countries.map(models.append)
                self.status = .didLoad
            }
        }
    }
    
    public func cancel() {
        self.requestService.cancel()
        self.status = .cancelled
    }
}
