//
//  UIButton+Extensions.swift
//  Square
//
//  Created by Student on 08.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

extension UIButton {
    
    public func setDesign(
        backgroundColor: UIColor,
        titleText: String,
        titleColor: UIColor
    ) {
        self.backgroundColor = backgroundColor
        self.setTitle(titleText, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
    }
}
