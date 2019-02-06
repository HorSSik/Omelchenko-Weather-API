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
    
    private let weatherNetworkService: WeatherNetworkService
    
    private let model: ObservableWrapper<Country>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.weatherTitle
    }
    
    init(
        country: ObservableWrapper<Country>,
        weatherNetworkService: WeatherNetworkService
    ) {
        self.weatherNetworkService = weatherNetworkService
        self.model = country
        
        super.init(nibName: nil, bundle: nil)
        
        self.subscribe()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subscribe() {
        self.weatherObserver.value = self.model.observer { country in
            dispatchOnMain {
                self.rootView?.fill(data: country.weather)
            }
        }
        
        self.weatherNetworkService.getWeather(country: model)
    }
}
