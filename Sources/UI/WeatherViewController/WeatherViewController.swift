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
    
    private var weatherObserver = CancellableProperty()
    
    private let weatherManager: WeatherNetworkManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.weatherTitle
    }
    
    init(weatherManager: WeatherNetworkManager) {
        self.weatherManager = weatherManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func fillModel(country: ObservableWrapper<Country>) {
        self.weatherObserver.value = country.observer { country in
            dispatchOnMain {
                self.rootView?.fill(data: country.weather)
            }
        }
        
        self.weatherManager.getWeather(country: country)
    }
}
