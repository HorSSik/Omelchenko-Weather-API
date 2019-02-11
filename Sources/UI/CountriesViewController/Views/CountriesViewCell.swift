//
//  CustomViewCell.swift
//  WeatherAPI
//
//  Created by Student on 21.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

class CountriesViewCell: TableViewCell {
    
    enum CountriesViewCellEvent {
        case cellNeedUpdate
    }

    @IBOutlet var temperature: UILabel?
    @IBOutlet var capital: UILabel?
    @IBOutlet var country: UILabel?
    @IBOutlet var date: UILabel?
    
    public var model: Country? {
        didSet {
            self.fill()
            
            self.prepareObserver()
        }
    }
    
    public var completion: F.Completion<CountriesViewCellEvent>?
    
    private let countryObserver = CancellableProperty()
    
    private func fill() {
        let country = self.model
        let weather = country?.weather
        
        self.country?.text = country?.name
        self.capital?.text = country?.capital
        
        self.temperature?.text = weather?.temp.map { String(Int($0)) }
        self.date?.text = weather?.date?.shortDescription
    }
    
    private func prepareObserver() {
        self.countryObserver.value = self.model?.observer { event in
            switch event {
            case .weatherDidChange(_):
                performOnMain {
                    self.fill()
                }
                
                self.completion?(.cellNeedUpdate)
            }
        }
    }
}
