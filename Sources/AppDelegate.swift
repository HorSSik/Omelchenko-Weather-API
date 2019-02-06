//
//  AppDelegate.swift
//  WeatherAPI
//
//  Created by Student on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
        -> Bool
    {
        let requestService = RequestService<[CountryJSON]>()
        let countriesNetworkManager = CountriesNetworkManager(requestService: requestService)
        let dataModel = CountriesModels()

        let rootViewController = CountriesViewController(
            model: dataModel,
            countriesNetworkManager: countriesNetworkManager
        )
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}

