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
        let dateLabel = self.date
        let country = model.country
        let temperature = self.temperature
        
        self.country?.text = country.value.name
        self.capital?.text = country.value.capital
        
        if let weather = model.weather.value {
            weather.temp.do { temperature?.text = String(Int($0)) }
            let date = Date(timeIntervalSince1970: TimeInterval(model.weather.value?.dt ?? 0))
            dateLabel?.text = date.shortDescription
        } else {
            temperature?.text = nil
            dateLabel?.text = nil
        }
    }
}
