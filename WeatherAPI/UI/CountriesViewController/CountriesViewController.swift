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
    
    private var model = Countries() {
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
        self.getCountries()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName = toString(CountriesViewCell.self)
        
        let cell = cast(self.rootView?.table?.dequeueReusableCell(withIdentifier: cellName))
            ?? CountriesViewCell()
        
        let item = self.model.countries[indexPath.row]
        cell.fill(country: item)
        
        return cell
    }

    private func getCountries() {
        let parserCountries = NetworkManager<[Country]>()
        
        let urlCountry = URL(string: "https://restcountries.eu/rest/v2/all")
        urlCountry.do {
            parserCountries.requestData(url: $0)
            
            _ = parserCountries.observer {
                switch $0 {
                case .didStartLoading: return
                case .didLoad: parserCountries.model.do { self.model = Countries(countries: $0) }
                case .didFailedWithError: return
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let capitalName = self.model.countries[indexPath.row].capital
        let weatherController = WeatherViewController()
        weatherController.city = capitalName
        self.navigationController?.pushViewController(weatherController, animated: true)
        
//        if let fillTemperature = self.rootView?.table?.cellForRow(at: indexPath) as? CountriesViewCell {
//            fillTemperature.temperature?.text = String(weatherController.weatherData?.temperature)
//        }
    }
}
