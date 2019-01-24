//
//  WeatherView.swift
//  WeatherAPI
//
//  Created by Student on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

class WeatherView: UIView {

    @IBOutlet var rangeTemperature: UILabel?
    @IBOutlet var humidity: UILabel?
    @IBOutlet var wind: UILabel?
    @IBOutlet var pressure: UILabel?
    @IBOutlet var emoji: UILabel?
    @IBOutlet var cityLabel: UILabel?
    @IBOutlet var label: UILabel?
    
    public func fillInTheData(data: WeatherJSON) {
        self.backgroundColor = Color.flatBlue.opaque
        
        let main = data.main
        let degrees = Unit.degrees
        
        let convertValue: (Double?, String) -> String = { nubmer, string in
            return nubmer.map { Int($0).description + string } ?? ""
        }
        
        let minTemp = convertValue(main.tempMin, degrees)
        let maxTemp = convertValue(main.tempMax, degrees)
        
        self.label?.text = convertValue(main.temp, degrees)
        self.cityLabel?.text = data.name
        self.emoji?.text = data.emoji?.rawValue
        
        self.rangeTemperature?.text = minTemp + Unit.split + maxTemp
        self.wind?.text = convertValue(data.wind.speed, Unit.metersPerSecond)
        
        self.humidity?.text = (main.humidity?.description ?? "") + Unit.percent
        self.pressure?.text = (main.pressure?.description ?? "") + Unit.hectopascal
    }
}
