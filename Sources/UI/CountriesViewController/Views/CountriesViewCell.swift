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
    
    public func fill(model: Country) {
        let weather = model.weather
        
        self.country?.text = model.name
        self.capital?.text = model.capital
        
        self.temperature?.text = weather?.temp.map { String(Int($0)) }
        self.date?.text = weather?.date?.shortDescription
    }
}
