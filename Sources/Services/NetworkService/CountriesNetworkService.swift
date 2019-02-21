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
    where DataBaseServise.Model == Country
{
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
                        let countries = Parser().countries(data: $0)
                        countries.analisys(
                            success: { value in
                                models.append(countries: value)
                                countries.value?.forEach { country in
                                    self.dataBaseService.add § country
                                    
                                    country.observer { _ in
                                        self.dataBaseService.add § country
                                    }
                                }
                            },
                            failure: {
                                self.fill § models
                                print($0.localizedDescription)
                            }
                        )
                    },
                    failure: {
                        self.fill § models
                        print($0.localizedDescription)
                    }
                )
            }
        }
        ?? .canceled()
    }
    
    private func fill(models: CountriesModel) {
        let countries = self.dataBaseService.read()
        
        countries.do(models.append)
    }
}
