//
//  CGRect+Extensions.swift
//  Square
//
//  Created by Student on 02.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import CoreGraphics

extension CGRect {
    
    enum Position {
        case topLeft
        case topRight
        case bottomRight
        case bottomLeft
        case leftCenter
        case rightCenter
        case center
        case topCenter
        case bottomCenter
    }
    
    var topLeft: CGPoint {
        return CGPoint(x: self.minX, y: self.minY)
    }
    
    var topRight: CGPoint {
        return CGPoint(x: self.maxX, y: self.minY)
    }
    
    var bottomRight: CGPoint {
        return CGPoint(x: self.maxX, y: self.maxY)
    }
    
    var bottomLeft: CGPoint {
        return CGPoint(x: self.minX, y: self.maxY)
    }
    
    var leftCenter: CGPoint {
        return CGPoint(x: self.minX, y: self.midY)
    }
    
    var rightCenter: CGPoint {
        return CGPoint(x: self.maxX, y: self.midY)
    }
    
    var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
    
    var topCenter: CGPoint {
        return CGPoint(x: self.midX, y: self.minY)
    }
    
    var bottomCenter: CGPoint {
        return CGPoint(x: self.midX, y: self.maxY)
    }
    
    func point(from position: Position) -> CGPoint {
        switch position {
        case .topLeft: return self.topLeft
        case .topRight: return self.topRight
        case .bottomRight: return self.bottomRight
        case .bottomLeft: return self.bottomLeft
        case .leftCenter: return self.leftCenter
        case .rightCenter: return self.rightCenter
        case .center: return self.center
        case .topCenter: return self.topCenter
        case .bottomCenter: return self.bottomCenter
        }
    }
}
