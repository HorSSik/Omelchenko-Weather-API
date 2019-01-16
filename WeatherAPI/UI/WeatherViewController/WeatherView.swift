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
    
    public func fillInTheData(data: WeatherData) {
        self.backgroundColor = Color.flatBlue.opaque
        self.label?.text = String(data.temperature) + "°"
        self.cityLabel?.text = data.city
        self.emoji?.text = data.emoji
        self.humidity?.text = String(data.humidity) + " %"
        self.rangeTemperature?.text = String(data.minTemperature) + "°" + "/ " + String(data.maxTemperature) + "°"
        self.wind?.text = String(data.wind) + "m/s"
        self.pressure?.text = String(data.pressure) + "hPa"
    }
}
