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
    
    var temperature = 0
    var city = ""
    var emoji = Emoji.sun.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        
        self.rootView?.label?.text = String(self.temperature) + "°"
        self.rootView?.cityLabel?.text = self.city
        self.rootView?.emoji?.text = self.emoji
    }
}
