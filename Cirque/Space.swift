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
    
    var ring: Int = 0
    var group: Int = 0
    var color: UIColor = .white { didSet { fillColor = color } }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(path: CGPath) {
        super.init()
        self.path = path
        self.isUserInteractionEnabled = true
    }
    
    convenience init(path: CGPath, ring: Int, group: Int) {
        self.init(path: path)
        self.ring = ring
        self.group = group
        self.color = UIColor(hue: CGFloat(group)/8.0, saturation: 0.4, brightness: 1.0, alpha: 1.0)
        fillColor = self.color
    }
}
