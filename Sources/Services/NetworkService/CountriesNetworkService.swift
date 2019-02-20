//
//  CountriesManager.swift
//  WeatherAPI
//
//  Created by Student on 17.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

import RealmSwift

fileprivate struct Constant {
    static let mainUrl = "https://restcountries.eu/rest/v2/all"
}

class CountriesNetworkService<DataBaseServise: DataBaseServiseType>
    where DataBaseServise.Model == RLMCountry
{
    
    private let parser = Parser()
    private let requestService: RequestServiceType
    private let dataBaseService: DataBaseServise
    
    init(requestService: RequestServiceType, dataBaseService: DataBaseServise) {
        self.requestService = requestService
        self.dataBaseService = dataBaseService
    }
    
    public func getCountries(models: CountriesModel) -> NetworkTask {
        let urlCountry = URL(string: Constant.mainUrl)
        
        return urlCountry.map { url in
            self.requestService.requestData(url: url) { result in
                result.analisys(
                    success: {
                        let countries = self.parser.countries(data: $0)
                        countries.analisys(
                            success: { value in
                                models.append(countries: value)
                                countries.value?.forEach {
                                    self.dataBaseService.add § RLMCountry.init § $0
                                }
                            },
                            failure: {
                                self.fill(models: models)
                                print($0.localizedDescription)
                            }
                        )
                    },
                    failure: {
                        self.fill(models: models)
                        print($0.localizedDescription)
                    }
                )
            }
        }
        ?? .canceled()
    }
    
    private func fill(models: CountriesModel) {
        let countries = self.dataBaseService.read()?.map {
            Country(name: $0.name, capital: $0.capital)
        }
        
        countries.do(models.append)
    }
}
