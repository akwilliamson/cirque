//
//  CGRect+Extension.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/2/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import CoreGraphics

extension CGRect {
    
    var minLength: CGFloat { return min(width, height) }
}
