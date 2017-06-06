//
//  Board.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/3/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import CoreGraphics
import SpriteKit

class Board: SKNode {
    
    let container: CGRect
    let center: CGPoint
    let radius: CGFloat
    let groups: CGFloat
    let groupMargin: CGFloat
    let rings: CGFloat
    let ringMargin: CGFloat
    var circumference: CGFloat
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(container: CGRect, groups: CGFloat, groupMargin: CGFloat, rings: CGFloat, ringMargin: CGFloat) {
        self.container     = container
        self.center        = container.center
        self.radius        = container.radius(0.4) // percentage of superview's smallest side length
        self.groups        = groups
        self.groupMargin   = groupMargin // in percentage
        self.rings         = rings
        self.ringMargin    = ringMargin // in points
        self.circumference = .tau - (groups * groupMargin) // Circle minus sum of all margin space
        super.init()
    }
    
    var lengthForSpace: CGFloat {
        return circumference * (1.0 / groups) // Constant for all spaces (percentage-based)
    }
    
    var widthForSpace: CGFloat {
        return radius / rings - ringMargin // Constant for all spaces (percentage-based)
    }
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return children
    }
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let space = context.nextFocusedItem as? SKShapeNode {
            space.alpha = 0.7
        }
        if let space = context.previouslyFocusedItem as? SKShapeNode {
            space.alpha = 1
        }
    }
    
    func generateSpaces() {
        
        var shape = Shape(center: center, length: lengthForSpace, width: widthForSpace, startRadius: radius)
        
        for i in 1...rings.int {
            for j in 1...groups.int {
                let space = Space(path: shape.path, colorIndex: j)
                space.isUserInteractionEnabled = true
                addChild(space)
                shape.startAngle = incrementStartAngleFor(j.cg)
            }
            shape.startRadius = incrementStartRadiusFor(i.cg)
        }
    }
    
    private func incrementStartAngleFor(_ groupNum: CGFloat) -> CGFloat {
        return circumference * (groupNum / groups) + (groupNum * groupMargin)
    }
    
    private func incrementStartRadiusFor(_ ringNum: CGFloat) -> CGFloat {
        return radius - (radius * ringNum / rings)
    }
}
