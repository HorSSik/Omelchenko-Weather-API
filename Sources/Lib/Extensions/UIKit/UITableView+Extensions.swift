//
//  UITableView+Extensions.swift
//  WeatherAPI
//
//  Created by Student on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(_ cellClass: AnyClass) {
        self.register(UINib(cellClass), forCellReuseIdentifier: toString(cellClass))
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(
        withCellClass cellClass: Cell.Type,
        configurator: ((Cell) -> ())? = nil
    )
        -> Cell
    {
        let cell = cast(self.dequeueReusableCell(withIdentifier: toString(cellClass))) ?? Cell()
        configurator?(cell)
        
        return cell
    }
    
    func dequeueReusableCell(withCellClass cellClass: AnyClass, for indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: toString(cellClass), for: indexPath)
    }
}
