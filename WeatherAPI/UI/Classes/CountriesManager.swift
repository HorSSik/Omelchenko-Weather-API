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
    
    public var completion: F.Completion<[Country]>?
    
    private var countryModel: [Country]?
    
    private let parserCountries = NetworkManager<[CountryJSON]>()
    
    public func getCountries() {
        let urlCountry = URL(string: Constant.mainUrl)
        
        urlCountry.do { url in
            self.parserCountries.requestData(url: url) { data, error in
                data.do { data in
                    var countryModel = self.countryModel
                    
                    countryModel = data.map {
                        Country(countryJSON: $0)
                    }
                    
                    countryModel.do { countries in
                        self.completion?(countries)
                    }
                }
            }
        }
    }
}
