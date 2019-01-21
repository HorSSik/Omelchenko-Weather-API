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
    
    public var escaping: F.Completion<Weather>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        
        self.weatherManager.completion = { weather in
            DispatchQueue.main.async {
                self.rootView?.fillInTheData(data: weather)
                self.escaping?(weather)
            }
        }
        
        self.weatherManager.parsWeather(capital: self.city)
    }
}
