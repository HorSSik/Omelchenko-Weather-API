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
    
    public var weatherManager = WeatherManager()
    public var city = "Default"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        
        self.weatherManager.completion = { weather in
            DispatchQueue.main.async {
                self.rootView?.fillInTheData(data: weather)
            }
        }
        
        self.weatherManager.parsWeather(capital: self.city)
    }
}
