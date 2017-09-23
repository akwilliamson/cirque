//
//  Int+Extension.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/2/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import CoreGraphics

extension Int {
    
    var cg: CGFloat {
        return CGFloat(self)
    }
    
    var index: Int {
        return self - 1
    }
    
    var incremented: Int {
        return index + 1
    }
    
    var decremented: Int {
        return index - 1
    }
    
    var doubleIncremented: Int {
        return index + 2
    }
    
    var doubleDecremented: Int {
        return index - 2
    }
}
