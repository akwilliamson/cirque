//
//  GameSpaceConverting.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/19/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import CoreGraphics

protocol GameSpaceConverting {
    
    func angleBetween(_ point1: CGPoint, and point2: CGPoint) -> CGFloat
    func distanceBetween(_ point1: CGPoint, and point2: CGPoint) -> CGFloat
}

extension GameSpaceConverting {
    
    func angleBetween(_ point1: CGPoint, and point2: CGPoint) -> CGFloat {
        let diffX = point2.x - point1.x
        let diffY = point2.y - point1.y
        let radians = atan2(diffY, diffX)
        // Adjusted from: 0 -> π -> -π -> 0 to: 0 -> π -> 2π -> 0
        return radians >= 0 ? radians : radians + .tau
    }
    
    func distanceBetween(_ point1: CGPoint, and point2: CGPoint) -> CGFloat {
        let diffX = point1.x - point2.x
        let diffY = point1.y - point2.y
        let distance = hypot(diffX, diffY)
        // 600.0 == scaled down Apple TV remote travel, arbitrary
        return min(distance/900.0, 1.0)
    }
}
