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
    
    public func fill(data: Weather?) {
        self.backgroundColor = Color.flatBlue.opaque
        
        let minTemp = stringWithDegrees(value: data?.tempMin)
        let maxTemp = stringWithDegrees(value: data?.tempMax)
        
        self.label?.text = stringWithDegrees(value: data?.temp)
        self.cityLabel?.text = data?.name
        self.emoji?.text = data?.emoji?.rawValue

        self.rangeTemperature?.text = stringWithUnit(value: minTemp, unit: .split) + maxTemp
        self.wind?.text = stringWithUnit(value: data?.windSpeed, unit: .metersPerSecond)
        
        self.humidity?.text = stringWithUnit(value: data?.humidity, unit: .percent)
        self.pressure?.text = stringWithUnit(value: data?.pressure, unit: .hectopascal)
    }
}
