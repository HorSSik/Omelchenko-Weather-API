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
        let requestService = RequestService(session: .init(configuration: .default))
        let countriesNetworkService = CountriesNetworkService(requestService: requestService)
        let dataModel = CountriesModel()

        let rootViewController = CountriesViewController(
            model: dataModel,
            countriesNetworkService: countriesNetworkService
        )
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}

