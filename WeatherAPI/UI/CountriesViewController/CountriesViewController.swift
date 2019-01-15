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
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
        -> UITableViewCell
    {
        let cellName = toString(CountriesViewCell.self)
        
        let cell = cast(self.rootView?.table?.dequeueReusableCell(withIdentifier: cellName))
            ?? CountriesViewCell()
        
        let item = self.model.countries[indexPath.row]
        cell.fill(country: item)
//        cell.textLabel?.text = ("\(item.name), \(item.capital)")

        return cell
    }

    private func getCountries() {
        let parserCountries = Parser<[Country]>()
        
        let urlCountry = URL(string: "https://restcountries.eu/rest/v2/all")
        
        guard let url = urlCountry else { return }
        parserCountries.requestData(url: url)
        
        _ = parserCountries.observer {
            switch $0 {
            case .notWorking: return
            case .didStartLoading: return
            case .didLoad: self.model = Countries(countries: parserCountries.model!)
            case .didFailedWithError: return
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let capitalName = self.model.countries[indexPath.row].capital
        let weatherController = WeatherViewController()
        let parserWeather = Parser<Weather>()
        
        let baseUrl = "https://api.openweathermap.org/data/2.5/weather?q=" + capitalName + "&units=metric&APPID=60cf95f166563b524e17c7573b54d7e3"
        let convertUrl = baseUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        convertUrl.do {
            if let url = URL(string: $0) { parserWeather.requestData(url: url) }
        }
        
        _ = parserWeather.observer { state in
            switch state {
            case .notWorking: return
            case .didStartLoading: return
            case .didLoad:
                parserWeather.model.do { weather in
                    let main = weather.main
                    
                    main["temp"].do { weatherController.temperature = Int($0) }
                    main["temp_min"].do { weatherController.minTemperature = Int($0) }
                    main["temp_max"].do { weatherController.maxTemperature = Int($0) }
                    main["humidity"].do { weatherController.humidity = Int($0) }
                    weather.wind["speed"].do { weatherController.wind = $0 }
                }
                let stateWeather = weatherController.temperature >= 0 ? Emoji.sun.rawValue : Emoji.winter.rawValue

                weatherController.city = capitalName.uppercased()
                weatherController.emoji = stateWeather
            case .didFailedWithError: return
            }
            
            self.navigationController?.pushViewController(weatherController, animated: true)
        }
    }
}
