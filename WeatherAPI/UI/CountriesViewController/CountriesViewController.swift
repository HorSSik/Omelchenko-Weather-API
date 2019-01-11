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
    
//    private var modelWeather = Weather() {
//        didSet {
//            DispatchQueue.main.async {
//                self.rootView?.table?.reloadData()
//            }
//        }
//    }
    
    private let identifier = "cell"
    private let urlCountry = URL(string: "https://restcountries.eu/rest/v2/all")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.table?.register(UITableViewCell.self, forCellReuseIdentifier: self.identifier)
        
        self.rootView?.table?.delegate = self
        self.rootView?.table?.dataSource = self
        self.requestData()
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
        let cell: UITableViewCell = self.rootView?.table?.dequeueReusableCell(withIdentifier: self.identifier)
            ?? UITableViewCell()
        let item = self.model.countries[indexPath.row]
        cell.textLabel?.text = ("\(item.name) , \(item.capital)")

        return cell
    }
    
    struct Countries: Codable {
        var countries = [Country]()
    }
    
    struct Country: Codable {
        var name: String
        var capital: String
    }
    
    struct Weather: Codable {
        var main: [String : Double]
    }

    private func requestData() {
        if let url = self.urlCountry {
            URLSession.shared.dataTask(with: url) { (data, respose, error) in
                let countries = data.flatMap { try? JSONDecoder().decode([Country].self, from: $0) }
                countries.do { self.model.countries = $0 }
            }.resume()
        }
    }
    
    private func getWeather(city: String) {
        let baseUrl = "https://api.openweathermap.org/data/2.5/weather?q="
        let apiKey = "&APPID=60cf95f166563b524e17c7573b54d7e3"
        var stateWeather = Emoji.sun.rawValue
        guard let url = URL(string: baseUrl + city + apiKey) else { return }
        URLSession.shared.dataTask(with: url) { (data, respose, error) in
            let weather = data.flatMap { try? JSONDecoder().decode(Weather.self, from: $0) }
            guard let temp = weather?.main["temp"] else { return }
            let temperature = self.translateInCelsius(temperature: temp)
            stateWeather = temperature >= 0 ? Emoji.sun.rawValue : Emoji.winter.rawValue
            print("Now in this country \(temperature)°C \(stateWeather) degrees")
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Your choice: \(self.model.countries[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
        
        let name = self.model.countries[indexPath.row].capital
        self.getWeather(city: name)
    }
    
    func translateInCelsius(temperature: Double) -> Int {
        return Int(temperature - 273.15)
    }
}
