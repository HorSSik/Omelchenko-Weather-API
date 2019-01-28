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
        
        let stringWithUnit = self.stringWithUnit
        let stringWithDegrees = self.stringWithDegrees
        
        let minTemp = stringWithDegrees(data.tempMin)
        let maxTemp = stringWithDegrees(data.tempMax)
        
        self.label?.text = stringWithDegrees(data.temp)
        self.cityLabel?.text = data.name
        self.emoji?.text = data.emoji?.rawValue

        self.rangeTemperature?.text = stringWithUnit(minTemp, .split) + maxTemp
        self.wind?.text = stringWithUnit(data.windSpeed, .metersPerSecond)
        
        self.humidity?.text = stringWithUnit(data.humidity, .percent)
        self.pressure?.text = stringWithUnit(data.pressure, .hectopascal)
    }
    
    private func stringWithUnit(value: CustomStringConvertible?, unit: Unit) -> String {
        return "\(value ?? "") \(unit)"
    }
    
    private func stringWithDegrees(value: CustomStringConvertible?) -> String {
        return self.stringWithUnit(value: value, unit: .degrees)
    }
}
