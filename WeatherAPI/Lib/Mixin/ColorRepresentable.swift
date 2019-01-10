//
//  ColorRepresentable.swift
//  Square
//
//  Created by Student on 09.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

protocol ColorRepresentable {
    
    var opaque: UIColor { get }
    
    func alpha(_ alpha: CGFloat) -> UIColor
}

extension ColorRepresentable where Self: RawRepresentable, Self.RawValue == UInt32 {
    
    var opaque: UIColor {
        return .init(rgb: self.rawValue)
    }
    
    func alpha(_ alpha: CGFloat) -> UIColor {
        return self.opaque.withAlphaComponent(alpha)
    }
}
