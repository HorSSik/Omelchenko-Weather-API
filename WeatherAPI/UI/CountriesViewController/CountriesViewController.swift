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
    
    private let identifier = "cell"
    private let url = URL(string: "https://restcountries.eu/rest/v2/all")
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.rootView?.table?.dequeueReusableCell(withIdentifier: self.identifier) as UITableViewCell!
        let item = self.model.countries[indexPath.row]
        cell.textLabel?.text = ("\(item.name), \(item.capital)")
//        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    struct Countries: Codable {
        var countries = [Country]()
    }
    
    struct Country: Codable {
        var name: String
        var capital: String
    }
    
    private func requestData() {
        if let url = self.url {
            URLSession.shared.dataTask(with: url) { (data, respose, error) in
                let countries = data.flatMap { try? JSONDecoder().decode([Country].self, from: $0) }
                countries.do { self.model.countries = $0 }
            }.resume()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select: \(self.model.countries[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
