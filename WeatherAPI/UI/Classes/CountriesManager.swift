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

class CountriesManager {
    
    public var completion: F.Completion<[CountryJSON]>?
    
    private let parserCountries = NetworkManager<[CountryJSON]>()
    
    init() {
        self.subscribe()
    }
    
    public func getCountries() {
        let urlCountry = URL(string: Constant.mainUrl)
        
        urlCountry.do(self.parserCountries.requestData)
    }
    
    private func subscribe() {
        _ = self.parserCountries.observer { state in
            switch state {
            case .didStartLoading: return
            case .didLoad:
                self.parserCountries.model.do { countries in
                    self.completion?(countries)
                }
            case .didFailedWithError: return
            }
        }
    }
}
