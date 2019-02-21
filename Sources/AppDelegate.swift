//
//  AppDelegate.swift
//  WeatherAPI
//
//  Created by Student on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
        -> Bool
    {
        let parser = Parser()
        let dataBaseService = CountryRealmDataBaseServise.init § RealmProvider()
        
        let countriesNetworkService = CountriesNetworkService(
            requestService: RequestService(),
            dataBaseService: dataBaseService
        )
        
        let dataModel = CountriesModel()
        
        let rootViewController = CountriesViewController(
            model: dataModel,
            countriesNetworkService: countriesNetworkService,
            parser: parser
        )
        
        let navigationController = UINavigationController.init § rootViewController
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}

