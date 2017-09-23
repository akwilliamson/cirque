//
//  Shaper.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/3/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit

struct GameSpaceShaper {
    
// MARK: Constant
    
    let center: CGPoint
    let length: CGFloat
    let width: CGFloat
    
// MARK: Variable
    
    var startAngle: CGFloat {
        didSet { endAngle = startAngle + length }
    }
    var startRadius: CGFloat {
        didSet { endRadius = startRadius - width }
    }
    var endAngle: CGFloat
    var endRadius: CGFloat
    
    var centerPoint: CGPoint {
        let centerX = startRadius - (width/2)
        let centerY = startAngle + (length/2)
        return CGPoint(x: centerX, y: centerY)
    }
    
    init(center: CGPoint, length: CGFloat, width: CGFloat, startAngle: CGFloat = 0.0, startRadius: CGFloat) {
        self.center      = center
        self.length      = length
        self.width       = width
        self.startAngle  = startAngle
        self.startRadius = startRadius
        self.endAngle    = startAngle + length
        self.endRadius   = startRadius - width
    }
    
    var path: CGPath {
        let path = UIBezierPath(arcCenter: center, radius: startRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
                    path.addArc(withCenter: center, radius: endRadius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
        
        return path.cgPath
    }
}
