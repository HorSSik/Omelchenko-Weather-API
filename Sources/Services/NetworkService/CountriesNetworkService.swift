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
    
    private let parser = Parser()
    private let requestService: RequestServiceType
    
    init(requestService: RequestServiceType) {
        self.requestService = requestService
    }
    
    public func getCountries(models: CountriesModel) -> NetworkTask{
        let urlCountry = URL(string: Constant.mainUrl)
        
        return urlCountry.map { url in
            self.requestService.requestData(url: url) { result in
                result.analisys(
                    success: {
                        let countries = self.parser.countries(data: $0)
                        countries.map(models.append)
                    },
                    failure: {
                        print($0.localizedDescription)
                    }
                )
            }
        } ?? .canceled()
    }
}
