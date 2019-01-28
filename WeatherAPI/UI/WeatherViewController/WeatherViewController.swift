//
//  WeatherViewController.swift
//  WeatherAPI
//
//  Created by Student on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

fileprivate struct Constant {
    static let cityName = "Default"
    static let titleWeather = "Weather"
}

class WeatherViewController: UIViewController, RootViewRepresentable {
    
    typealias RootView = WeatherView
    
    public var city = Constant.cityName
    
    public let weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.titleWeather
        
        let weatherManager = self.weatherManager
        
        _ = weatherManager.observer { weather in
            dispatchOnMain {
                self.rootView?.fillInTheData(data: weather)
            }
        }
        
        weatherManager.getWeather(capital: self.city)
    }
}
