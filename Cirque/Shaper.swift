//
//  Shaper.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/3/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit

struct Shaper {
    
    // Constant for every generated space shape
    let center:      CGPoint
    let width:       CGFloat
    let length:      CGFloat
    // Changes for every generated space shape
    var startRadius: CGFloat { didSet { endRadius = startRadius - width } } // Outward radius
    var endRadius:   CGFloat                                                // Inward radius
    var startAngle:  CGFloat { didSet { endAngle = startAngle + length } }
    var endAngle:    CGFloat
    
    init(center: CGPoint, length: CGFloat, width: CGFloat, startAngle: CGFloat = 0.0, startRadius: CGFloat) {
        self.center      = center
        self.length      = length
        self.width       = width
        self.startAngle  = startAngle
        self.startRadius = startRadius
        self.endRadius   = startRadius - width
        self.endAngle    = startAngle + length
    }
    
    var path: CGPath {
        let path = UIBezierPath(arcCenter: center, radius: startRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.addArc(withCenter: center, radius: endRadius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
        
        return path.cgPath
    }
}
