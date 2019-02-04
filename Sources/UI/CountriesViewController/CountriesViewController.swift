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
    
    private var dataModel = Models()
    
    private var cancelledObserver = CancellableProperty()
    
    private let countriesManager: CountriesManager
    
    init(requestService: RequestService<[CountryJSON]>) {
        self.countriesManager = CountriesManager(requestService: requestService)
        
        super.init(nibName: nil, bundle: nil)
        
        self.subscribe(indexPath: nil)
        
        self.countriesManager.getCountries(models: dataModel)
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
        
        let requestService = RequestService<WeatherJSON>()
        let weatherController = WeatherViewController(requestService: requestService)
        
        let country = self.dataModel[indexPath.row]
        
        self.subscribe(indexPath: indexPath)

        weatherController.fillModel(country: country)
        
        self.navigationController?.pushViewController(weatherController, animated: true)
    }
    
    private func subscribe(indexPath: IndexPath?) {
        self.cancelledObserver.value = self.dataModel.observer { state in
            switch state {
            case .modelsRefreshed(_):
                indexPath.do { indexPath in
                    dispatchOnMain {
                        self.rootView?.table?.reloadRows(at: [indexPath], with: .none)
                    }
                }
            default: self.reloadData()
            }
        }
    }
    
    private func reloadData() {
        dispatchOnMain {
            self.rootView?.table?.reloadData()
        }
    }
}
