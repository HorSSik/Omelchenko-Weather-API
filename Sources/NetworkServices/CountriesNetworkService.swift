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

class CountriesNetworkService {
    
    private let requestService: RequestServiceType
    
    private let parser = Parser()
    
    init(requestService: RequestServiceType) {
        self.requestService = requestService
    }
    
    public func getCountries(models: CountriesModel) {
        let urlCountry = URL(string: Constant.mainUrl)
        
        urlCountry.do { url in
            self.requestService.requestData(url: url) { data, response, error in
                let countries = self.parser.countries(data: data)
                countries.map(models.append)
            }
        }
    }
}
