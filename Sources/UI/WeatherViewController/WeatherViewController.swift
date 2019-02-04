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
    
    private var cancelledObserver = CancellableProperty()
    
    private let weatherManager: WeatherManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.weatherTitle
    }
    
    init(requestService: RequestService<WeatherJSON>) {
        self.weatherManager = WeatherManager(requestService: requestService)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func fillModel(country: Wrapper<Country>) {
        self.weatherManager.getWeather(country: country)
        
        self.cancelledObserver.value = country.observer { country in
            dispatchOnMain {
                self.rootView?.fill(data: country.weather)
            }
        }
    }
}
