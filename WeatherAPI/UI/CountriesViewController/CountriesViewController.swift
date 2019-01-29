//
//  CountriesViewController.swift
//  WeatherAPI
//
//  Created by Student on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

fileprivate struct Constant {
    static let countriesTitle = "Country and capital"
}

class CountriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    private var countriesManager = CountriesManager()
    
    private var dataModel: Models? {
        didSet {
            _ = self.dataModel?.observer { state in
                switch state {
                case .weatherLoad(_):
                    self.reloadData()
                case .countryLoad(_): break
                }
            }
            self.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.countriesTitle
        
        self.rootView?.table?.register(CountriesViewCell.self)
        
        self.fillModel()
    }
    
    private func fillModel() {
        let countriesManager = self.countriesManager
        
        _ = countriesManager.observer {
            self.dataModel = Models(models: $0.map(Model.init))
        }
        
        countriesManager.getCountries()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataModel?.values.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withCellClass: CountriesViewCell.self) { cell in
            self.dataModel.do { value in
                cell.fill(with: value.values[indexPath.row])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
      
        let weatherController = WeatherViewController()
        let model = self.dataModel?.values[indexPath.row]
        weatherController.model = model
        
        self.navigationController?.pushViewController(weatherController, animated: true)
    }
    
    private func reloadData() {
        dispatchOnMain {
            self.rootView?.table?.reloadData()
        }
    }
}
