//
//  Space.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/3/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import CoreGraphics
import SpriteKit

class Space: SKShapeNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(path: CGPath) {
        super.init()
        self.path = path
    }
    
    convenience init(path: CGPath, colorIndex: Int) {
        self.init(path: path)
        fillColor = colorIndex < 8 ? Color(rawValue: colorIndex)!.color : UIColor.gray
    }
}
