//
//  SpaceMapping.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/19/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import CoreGraphics

protocol SpaceMapping {
    
    func angleBetween(_ pointOne: CGPoint, and pointTwo: CGPoint) -> CGFloat
    func distanceBetween(_ pointOne: CGPoint, and pointTwo: CGPoint) -> CGFloat
}

extension SpaceMapping {
    
    func angleBetween(_ pointOne: CGPoint, and pointTwo: CGPoint) -> CGFloat {
        let diffX = pointTwo.x - pointOne.x
        let diffY = pointTwo.y - pointOne.y
        let radians = atan2(diffY, diffX)
        // Adjusted from: 0 -> π -> -π -> 0 to: 0 -> π -> 2π -> 0
        return radians >= 0 ? radians : radians + .tau
    }
    
    func distanceBetween(_ pointOne: CGPoint, and pointTwo: CGPoint) -> CGFloat {
        let diffX = pointOne.x - pointTwo.x
        let diffY = pointOne.y - pointTwo.y
        let distance = hypot(diffX, diffY)
        // 600.0 == scaled down Apple TV remote travel, arbitrary
        return min(distance/900.0, 1.0)
    }
}
