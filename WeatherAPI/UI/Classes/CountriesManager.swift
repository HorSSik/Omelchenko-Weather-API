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

class CountriesManager: ObservableObject<[Country]> {
    
    private var countryModel: [Country]? {
        didSet {
            self.countryModel.do(self.notify)
        }
    }
    
    private let countriesService = RequestService<[CountryJSON]>()
    
    public func getCountries() {
        let urlCountry = URL(string: Constant.mainUrl)
        
        urlCountry.do { url in
            self.countriesService.requestData(url: url) { data, error in
                data.do { data in
                    self.countryModel = data
                        .filter {
                            !$0.capital.isEmpty
                        }
                        .map {
                            Country(countryJSON: $0)
                        }
                }
            }
        }
    }
}
