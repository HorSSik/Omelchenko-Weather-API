//
//  CustomViewCell.swift
//  WeatherAPI
//
//  Created by Student on 21.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

class CountriesViewCell: TableViewCell {

    @IBOutlet var temperature: UILabel?
    @IBOutlet var capital: UILabel?
    @IBOutlet var country: UILabel?
    @IBOutlet var date: UILabel?
    
    public func fill(with model: Model) {
        let country = model.country
        let weather = model.weather.value
        
        self.country?.text = country.value.name
        self.capital?.text = country.value.capital
        
        self.temperature?.text = weather?.temp.map { String(Int($0)) }
        self.date?.text = model.weather.value?.dt?.shortDescription
    }
}
