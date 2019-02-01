//
//  NoIdentifier.swift
//  WeatherAPI
//
//  Created by Student on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    override var reuseIdentifier: String? {
        return toString(type(of: self))
    }
}
