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
    
    public func fill(country: Country) {
        let weather = country.weather
        
        self.country?.text = country.name
        self.capital?.text = country.capital
        
        self.temperature?.text = weather?.temp.map { String(Int($0)) }
        self.date?.text = weather?.date?.shortDescription
    }
}
