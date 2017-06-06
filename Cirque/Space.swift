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
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(path: CGPath) {
        super.init()
        self.path = path
    }
    
    convenience init(path: CGPath, colorIndex: Int) {
        self.init(path: path)
        
        
        let hue: CGFloat = CGFloat(colorIndex)/8.0
        fillColor = UIColor(hue: hue, saturation: 0.4, brightness: 1.0, alpha: 1.0)
        //fillColor = colorIndex < 8 ? Color(rawValue: colorIndex)!.color : UIColor.gray
    }
}
