//
//  Board.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/3/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit
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
        self.circumference = .tau // Circle minus sum of all margin space
        super.init()
    }
    
    /** DONT YOU DARE LOOK AT THIS **/
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first else { return }
        children.forEach {
            guard let space = $0 as? Space else { return }
            space.fillColor = space.contains(touch.location(in: self)) ? .gray : space.color
        }
    }
    
    var lengthForSpace: CGFloat {
        return circumference * (1.0 / groups) // Constant for all spaces (percentage-based)
    }
    
    var widthForSpace: CGFloat {
        return radius / rings - ringMargin // Constant for all spaces (percentage-based)
    }
    
    func generateSpaces() {
        
        var shape = Shape(center: center, length: lengthForSpace, width: widthForSpace, startRadius: radius)
        
        for ring in 1...rings.int {
            for group in 1...groups.int {
                addChild(Space(path: shape.path, ring: ring, group: group))
                shape.startAngle = incrementStartAngleFor(group.cg)
            }
            shape.startRadius = incrementStartRadiusFor(ring.cg)
        }
    }
    
    private func incrementStartAngleFor(_ groupNum: CGFloat) -> CGFloat {
        return circumference * (groupNum / groups)
    }
    
    private func incrementStartRadiusFor(_ ringNum: CGFloat) -> CGFloat {
        return radius - (radius * ringNum / rings)
    }
}
