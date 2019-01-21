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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func fillOutOfThe(model: BaseModel) {
        self.country?.text = model.country.name
        self.capital?.text = model.country.capital
        
        if let weather = model.weather {
            weather.main.temp.do { self.temperature?.text = String(Int($0)) }
            let data = Date(timeIntervalSince1970: TimeInterval(model.weather?.dt ?? 0))
            self.date?.text = data.shortDescription
        } else {
            self.temperature?.text = nil
            self.date?.text = nil
        }
    }
}
