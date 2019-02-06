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
    
    private let modelObserver = CancellableProperty()
    
    private let dataModel: CountriesModels
    private let countriesNetworkService: CountriesNetworkService
    
    init(model: CountriesModels, countriesNetworkService: CountriesNetworkService) {
        self.countriesNetworkService = countriesNetworkService
        self.dataModel = model
        
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
        return self.dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withCellClass: CountriesViewCell.self) { cell in
            cell.fill(country: self.dataModel[indexPath.row].value)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = self.dataModel[indexPath.row]
        
        let requestService = RequestService()
        let weatherNetworkService = WeatherNetworkService(requestService: requestService)
        let weatherController = WeatherViewController(country: country, weatherNetworkService: weatherNetworkService)
        
        country.observer { _ in
            dispatchOnMain {
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        
        self.navigationController?.pushViewController(weatherController, animated: true)
    }
    
    private func prepareCountriesNetworkService() {
        let reloadData = self.reloadData
        let dataModel = self.dataModel
        
        self.modelObserver.value = dataModel.observer { state in
            switch state {
            case .modelsRefreshed: return
            case .modelsDidAppend: reloadData()
            case .modelsDidRemove: reloadData()
            case .modelsDeleted: reloadData()
            }
        }
        
        self.countriesNetworkService.getCountries(models: dataModel)
    }
    
    private func reloadData() {
        dispatchOnMain {
            self.rootView?.table?.reloadData()
        }
    }
}
