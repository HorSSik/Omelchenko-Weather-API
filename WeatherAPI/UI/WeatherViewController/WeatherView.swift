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
    
    public func fillInTheData(data: Weather) {
        self.backgroundColor = Color.flatBlue.opaque
        
        let degrees = Unit.degrees
        
        let convertValue: (Double?, String) -> String = { nubmer, string in
            return nubmer.map { Int($0).description + string } ?? ""
        }
        
        let minTemp = convertValue(data.tempMin, degrees)
        let maxTemp = convertValue(data.tempMax, degrees)
        
        self.label?.text = convertValue(data.temp, degrees)
        self.cityLabel?.text = data.name
        self.emoji?.text = data.emoji?.rawValue
        
        self.rangeTemperature?.text = minTemp + Unit.split + maxTemp
        self.wind?.text = convertValue(data.windSpeed, Unit.metersPerSecond)
        
        self.humidity?.text = (data.humidity?.description ?? "") + Unit.percent
        self.pressure?.text = (data.pressure?.description ?? "") + Unit.hectopascal
    }
}
