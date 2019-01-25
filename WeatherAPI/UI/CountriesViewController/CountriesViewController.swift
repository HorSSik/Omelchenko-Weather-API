//
//  CountriesViewController.swift
//  WeatherAPI
//
//  Created by Student on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

fileprivate struct Constant {
    static let titleCountries = "Country and capital"
}

class CountriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    private var countriesManager = CountriesManager()
    
    private var model = [BaseModel]() {
        didSet {
            dispatchOnMain {
                self.rootView?.table?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.titleCountries
        
        self.rootView?.table?.register(CountriesViewCell.self)
        
        self.countriesManager.completion = {
            self.model = $0
                .filter {
                    !$0.capital.isEmpty
                }
                .map { country in
                    BaseModel(country: country)
                }
        }

        self.countriesManager.getCountries()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withCellClass: CountriesViewCell.self) {
            $0.fill(with: self.model[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
      
        let weatherController = WeatherViewController()
        weatherController.city = self.model[indexPath.row].country.capital
        self.navigationController?.pushViewController(weatherController, animated: true)
        
//        weatherController.escaping = {
//            self.model[indexPath.row].weather = $0
//            dispatchOnMain {
//               self.rootView?.table?.reloadData()
//            }
//        }
    }
}
