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
    
    public var weatherData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        
        self.weatherData.do {
            self.rootView?.fillInTheData(data: $0)
        }
    }
}
