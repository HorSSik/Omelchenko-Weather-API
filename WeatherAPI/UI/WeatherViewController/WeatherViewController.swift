//
//  WeatherViewController.swift
//  WeatherAPI
//
//  Created by Student on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, RootViewRepresentable {
    
    typealias RootView = WeatherView
    
    public var temperature = 0
    public var maxTemperature = 0
    public var minTemperature = 0
    public var city = ""
    public var emoji = Emoji.sun.rawValue
    public var humidity = 0
    public var wind = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        
        self.rootView?.backgroundColor = Color.flatBlue.opaque
        self.rootView?.label?.text = String(self.temperature) + "°"
        self.rootView?.cityLabel?.text = self.city
        self.rootView?.emoji?.text = self.emoji
        self.rootView?.humidity?.text = String(self.humidity) + " %"
        self.rootView?.rangeTemperature?.text = String(self.minTemperature) + "°" + "/ " + String(self.maxTemperature) + "°"
    }
}
