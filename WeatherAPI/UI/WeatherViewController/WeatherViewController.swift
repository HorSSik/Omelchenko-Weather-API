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
    
    public var city = "Default"
    public var escaping: F.Completion<Weather>?
    
    public let weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        
        let weatherManager = self.weatherManager
        
        weatherManager.completion = { weather in
            DispatchQueue.main.async {
                self.rootView?.fillInTheData(data: weather)
                self.escaping?(weather)
            }
        }
        
        weatherManager.parsWeather(capital: self.city)
    }
}
