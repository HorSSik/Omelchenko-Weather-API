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
    
    private let requestService: RequestService<[CountryJSON]>
    
    private let parser = Parser()
    
    init(requestService: RequestService<[CountryJSON]>) {
        self.requestService = requestService
    }
    
    public func getCountries(models: Models) {
        let urlCountry = URL(string: Constant.mainUrl)
        
        urlCountry.do { url in
            self.requestService.requestData(url: url) { data, error in
                data.do { data in
                    data
                        .filter {
                            !$0.capital.isEmpty
                        }
                        .forEach {
                            models.add(country: self.parser.filledCountry(countryJSON: $0))
                        }
                }
            }
        }
    }
}
