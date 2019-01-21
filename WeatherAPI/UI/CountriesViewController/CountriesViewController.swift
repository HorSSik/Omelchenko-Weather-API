//
//  CountriesViewController.swift
//  WeatherAPI
//
//  Created by Student on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    private var countriesManager = CountriesManager()
    
    private var model = [BaseModel]() {
        didSet {
            DispatchQueue.main.async {
                self.rootView?.table?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Country and capital"
        
        self.rootView?.table?.register(CountriesViewCell.self)
        
        self.rootView?.table?.delegate = self
        self.rootView?.table?.dataSource = self
        
        self.countriesManager.completion = {
            self.model = $0.filter { !$0.capital.isEmpty }
                .map(BaseModel.init)
        }

        self.countriesManager.parsCountries()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellClass = toString(CountriesViewCell.self)
        
        let cell = cast(self.rootView?.table?.dequeueReusableCell(withIdentifier: cellClass))
            ?? CountriesViewCell()
        
        let item = self.model[indexPath.row]
        cell.fillOutOfThe(model: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
      
        let weatherController = WeatherViewController()
        weatherController.city = self.model[indexPath.row].country.capital
        self.navigationController?.pushViewController(weatherController, animated: true)
        
        weatherController.escaping = {
            self.model[indexPath.row].weather = $0
            DispatchQueue.main.async {
                self.rootView?.table?.reloadData()
            }
        }
    }
}
