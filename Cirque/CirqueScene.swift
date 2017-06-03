//
//  CirqueScene.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/2/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import SpriteKit

class CirqueScene: SKScene {
    
    // Number of color groups in the game
    let groupCount: CGFloat = 8.0
    
    // Number of rings in the group
    let ringCount: CGFloat = 5.0
    
    // Size of the game board is 80% of the containing view
    lazy var radius: CGFloat = {
        return self.frame.minLength * 0.4
    }()
    
    // Percentage of the circle allocated to empty space, divided equally among the number of groups
    let margin: CGFloat = 0.02
    
    // Width of a space, which is 1/5 of the radius (for 5 levels)
    lazy var width: CGFloat = {
        return self.radius / self.ringCount - 3
    }()
    
    // Full circle minus the sum of all margin space
    lazy var circumference: CGFloat = {
        return .tau - (self.groupCount * self.margin)
    }()
    
    // Fraction of circumference arc dedicated to each group
    lazy var length: CGFloat = {
        return self.circumference * (1.0 / self.groupCount)
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        var shape = Shape(center: view.center, width: width, length: length, radius: radius)
        
        for i in 1...ringCount.int {
            for i in 0..<groupCount.int {
                shape.start = circumference * (i.cg / groupCount) + (i.cg * margin)
                let spaceNode = shapeFor(path: shape.path, colorIndex: i)
                addChild(spaceNode)
            }
            shape.radiusOut = radius - (radius * i.cg/ringCount)
        }
    }
    
    func shapeFor(path: CGPath, colorIndex: Int) -> SKShapeNode {
        let layer = SKShapeNode(path: path)
        layer.fillColor = colorIndex < 8 ? Color(rawValue: colorIndex)!.color : UIColor.gray // Only 8 colors in this example
        return layer
    }
}
