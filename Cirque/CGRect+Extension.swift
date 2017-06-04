//
//  CGRect+Extension.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/2/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import CoreGraphics

extension CGRect {
    
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
    
    // Based on the shortest length of the frame
    func radius(_ percentage: CGFloat) -> CGFloat {
        return min(width, height) * percentage
    }
}
