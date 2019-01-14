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
    
    var stateWeather = Emoji.sun.rawValue
    
    private let parserCountries = Parser<[Country]>()
    
    private var model = Countries() {
        didSet {
            DispatchQueue.main.async {
                self.rootView?.table?.reloadData()
            }
        }
    }
    
    private let urlCountry = URL(string: "https://restcountries.eu/rest/v2/all")
    private var temperature = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Country and capital"
        
        self.rootView?.table?.register(TableViewCell.self)
        
        self.rootView?.table?.delegate = self
        self.rootView?.table?.dataSource = self
        self.getCountries()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.countries.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
        -> UITableViewCell
    {
        let cellName = toString(Cell.self)
        
        let cell: UITableViewCell = self.rootView?.table?.dequeueReusableCell(withIdentifier: cellName)
            ?? UITableViewCell()
        let item = self.model.countries[indexPath.row]
        cell.textLabel?.text = ("\(item.name), \(item.capital)")

        return cell
    }

    private func getCountries() {
        guard let url = self.urlCountry else { return }
        self.parserCountries.requestData(url: url)
        
        let observer = self.parserCountries.observer {
            switch $0 {
            case .notWorking:
                return
            case .didStartLoading:
                return
            case .didLoad:
                self.model = Countries(countries: self.parserCountries.model!)
            case .didFailedWithError(_):
                return
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let name = self.model.countries[indexPath.row].capital
        let controller = WeatherViewController()
        let parser = Parser<Weather>()
        
        let baseUrl = "https://api.openweathermap.org/data/2.5/weather?q=" + name + "&APPID=60cf95f166563b524e17c7573b54d7e3"
        
        guard let url = URL(string: baseUrl) else { return }
        
        parser.requestData(url: url)
        
        _ = parser.observer { state in
            switch state {
            case .notWorking:
                return
            case .didStartLoading:
                return
            case .didLoad:
                guard let temp = parser.model?.main["temp"] else { return }
                self.temperature = self.translateInCelsius(temperature: temp)
                self.stateWeather = self.temperature >= 0 ? Emoji.sun.rawValue : Emoji.winter.rawValue
                
                controller.temperature = self.temperature
                controller.city = name.uppercased()
                controller.emoji = self.stateWeather
            case .didFailedWithError(_):
                return
            }
            
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func translateInCelsius(temperature: Double) -> Int {
        return Int(temperature - 273.15)
    }
}



//print("Your choice: \(self.model.countries[indexPath.row])")
//print("Now in this country \(self.temperature)°C \(self.stateWeather) degrees")
