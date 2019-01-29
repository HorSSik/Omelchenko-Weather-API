//
//  WeatherViewController.swift
//  WeatherAPI
//
//  Created by Student on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

fileprivate struct Constant {
    static let weatherTitle = "Weather"
}

class WeatherViewController: UIViewController, RootViewRepresentable {
    
    typealias RootView = WeatherView
    
    public let weatherManager = WeatherManager()
    
    public var model: Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.weatherTitle
        
        self.fillModel()
    }
    
    private func fillModel() {
        let weatherManager = self.weatherManager
        
        _ = weatherManager.observer { weather in
            dispatchOnMain {
                self.rootView?.fill(data: weather)
            }
            
            self.model?.weather.value = weather
        }
        
        weatherManager.getWeather(capital: self.model?.country.value.capital ?? "")
    }
}
