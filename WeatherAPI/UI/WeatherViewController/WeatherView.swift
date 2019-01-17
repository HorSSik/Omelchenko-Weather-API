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
        
        self.label?.text = data.main.temp.description + "°"
        self.cityLabel?.text = data.name
        self.emoji?.text = data.emoji.rawValue
        self.humidity?.text = data.main.humidity.description + " %"
        self.rangeTemperature?.text = data.main.tempMin.description + "°" + "/ " + data.main.tempMax.description + "°"
        self.wind?.text = data.wind.speed.description + "m/s"
        self.pressure?.text = data.main.pressure.description + "hPa"
    }
}
