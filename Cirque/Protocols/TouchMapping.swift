//
//  TouchMapping.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/19/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

/**
 
 Converts a touch trajectory into angle and distance to pass to `Board` to highlight
 the `Space` containing said trajectory.
 
 Conforming Types: CirqueScene
 
**/

import CoreGraphics

protocol TouchMapping {
    
    func angleBetween(_ pointOne: CGPoint, and pointTwo: CGPoint) -> CGFloat
    func distanceBetween(_ pointOne: CGPoint, and pointTwo: CGPoint) -> CGFloat
}

extension TouchMapping {
    
    func angleBetween(_ pointOne: CGPoint, and pointTwo: CGPoint) -> CGFloat {
        let diffX = pointTwo.x - pointOne.x
        let diffY = pointTwo.y - pointOne.y
        let radians = atan2(diffY, diffX)
        
        return radians >= 0 ? radians : radians + .tau // Adjusted from: 0 -> π -> -π -> 0 to: 0 -> π -> 2π -> 0
    }
    
    func distanceBetween(_ pointOne: CGPoint, and pointTwo: CGPoint) -> CGFloat {
        let diffX = pointOne.x - pointTwo.x
        let diffY = pointOne.y - pointTwo.y
        let distance = hypot(diffX, diffY)

        return min(distance/900.0, 1.0) // scaled down Apple TV remote travel, arbitrary
    }
}
