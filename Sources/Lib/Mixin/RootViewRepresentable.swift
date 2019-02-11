//
//  RootViewRepresentable.swift
//  Square
//
//  Created by Student on 03.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

protocol RootViewRepresentable {
    
    associatedtype RootView: UIView
}

extension RootViewRepresentable where Self: UIViewController {
    
    var rootView: RootView? {
        return cast(viewIfLoaded)
    }
}
