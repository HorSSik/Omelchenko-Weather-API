//
//  CountriesViewController.swift
//  WeatherAPI
//
//  Created by Student on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit
import Alamofire

fileprivate struct Constant {
    static let countriesTitle = "Country and capital"
}

class CountriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    private var task: NetworkTask?

    private let parser: Parser
    private let countries: CountriesModel
    private let modelObserver = CancellableProperty()
    private let countriesNetworkService: CountriesNetworkService<CountryRealmDataBaseServise>
    
    init(
        model: CountriesModel,
        countriesNetworkService: CountriesNetworkService<CountryRealmDataBaseServise>,
        parser: Parser
    ) {
        self.countriesNetworkService = countriesNetworkService
        self.countries = model
        self.parser = parser
        
        super.init(nibName: nil, bundle: nil)
        
        self.prepareCountriesNetworkService()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.countriesTitle
        
        self.rootView?.table?.register(CountriesViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withCellClass: CountriesViewCell.self) { cell in
            cell.model = self.countries[indexPath.row]
            
            cell.completion = { _ in
                performOnMain {
                    tableView.reloadRows(at: [indexPath], with: .none)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = self.countries[indexPath.row]
        
        let requestService = RequestService()
        let dataBaseService = WeatherRealmDataBaseServise.init § RealmProvider()
        
        let weatherNetworkService = WeatherNetworkService(
            requestService: requestService,
            dataBaseService: dataBaseService,
            parser: self.parser
        )
        
        let weatherController = WeatherViewController(country: country, weatherNetworkService: weatherNetworkService)
        self.navigationController?.pushViewController(weatherController, animated: true)
    }
    
    private func prepareCountriesNetworkService() {
        let model = self.countries
        
        self.modelObserver.value = model.observer { [weak self] state in
            switch state {
            case .didAppendCountry: return
            case .didRemoveCountry: return
            case .didRefreshCountries: self?.reloadData()
            }
        }
        
        self.task = self.countriesNetworkService.getCountries § model
    }
    
    private func reloadData() {
        performOnMain {
            self.rootView?.table?.reloadData()
        }
    }
}
