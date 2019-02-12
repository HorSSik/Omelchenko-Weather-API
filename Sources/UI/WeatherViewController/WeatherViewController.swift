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
    
    private var task: NetworkTask?
    
    private let country: Country
    private let weatherObserver = CancellableProperty()
    private let weatherNetworkService: WeatherNetworkService
    
    init(
        country: Country,
        weatherNetworkService: WeatherNetworkService
    ) {
        self.weatherNetworkService = weatherNetworkService
        self.country = country
        
        super.init(nibName: nil, bundle: nil)
        
        self.subscribe()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.weatherTitle
        
        self.fillView(weather: self.country.weather)
    }
    
    private func subscribe() {
        let country = self.country
        
        self.weatherObserver.value = country.observer { state in
            switch state {
            case let .weatherDidChange(weather):
                self.fillView § weather
            }
        }

        self.task = self.weatherNetworkService.getWeather(country: country)
    }
    
    private func fillView(weather: Weather?) {
        performOnMain {
            self.rootView?.fill(data: weather)
        }
    }
}
