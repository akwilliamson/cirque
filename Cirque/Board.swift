//
//  Board.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/3/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit
import SpriteKit

protocol RadialMenu {
    func select(atAngle angle: CGFloat, percentOfRadius: CGFloat)
}

class Board: SKNode {
    
    let container: CGRect
    let center: CGPoint
    let radius: CGFloat
    let groups: CGFloat
    let rings: CGFloat
    var circumference: CGFloat
    
    // The spacing between each concentric ring. An arbitrary value
    let ringMargin: CGFloat = 5
    // The percentage of the radius devoted to the open center of the game board. An arbitrary value
    let openCenterPercentageOfRadius: CGFloat = 0.1
    
    var gameSpaces = [[GameSpace]]()
    var ringMapping = [Int: ClosedRange<CGFloat>]()
    var groupMapping = [Int: ClosedRange<CGFloat>]()
    
    var selectedGameSpace: GameSpace?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(container: CGRect, groups: CGFloat, rings: CGFloat) {
        self.container     = container
        self.center        = container.center
        self.radius        = container.radius(0.4) // percentage of superview's smallest side length
        self.groups        = groups
        self.rings         = rings
        self.circumference = .tau // Circle minus sum of all margin space
        super.init()
    }
    
    var lengthForSpace: CGFloat {
        return circumference/groups
    }
    
    var widthForSpace: CGFloat {
        return radius/rings - ringMargin
    }
    
    func generateSpaces() {
        
        var shaper = Shaper(center: center, length: lengthForSpace, width: widthForSpace, startRadius: radius)
        
        for ringNum in 1...rings.int {
            gameSpaces.append(Array())
            let ringIndex = ringNum - 1
            for groupNum in 1...groups.int {
                let groupIndex = groupNum - 1
                if groupMapping[groupIndex] == nil {
                    groupMapping[groupIndex] = (shaper.startAngle...shaper.endAngle)
                }
                let gameSpace = GameSpace(path: shaper.path, ringNum: ringNum, groupNum: groupNum)
                gameSpaces[ringIndex].append(gameSpace)
                addChild(gameSpace)
                shaper.startAngle = incrementStartAngleFor(groupNum.cg)
            }
            ringMapping[ringIndex] = (shaper.endRadius...shaper.startRadius)
            shaper.startRadius = incrementStartRadiusFor(ringNum.cg)
        }
    }
    
    private func incrementStartAngleFor(_ groupNum: CGFloat) -> CGFloat {
        return groupNum/groups * circumference // 1/X % of circumference
    }
    
    private func incrementStartRadiusFor(_ ringNum: CGFloat) -> CGFloat {
        let percentageOfRadiusForRing = 1 - ringNum/rings
        let percentageOfShrinkForRing = openCenterPercentageOfRadius * ringNum/rings
        return radius * (percentageOfRadiusForRing + percentageOfShrinkForRing)
    }
}

extension Board: RadialMenu {
    
    func select(atAngle angle: CGFloat, percentOfRadius: CGFloat) {
        // Counter-clockwise in the top half of the circle, the angle goes from 0 -> π
        // Continuing counter-clockwise in the bottome half, the angles goes from -π -> 0
        // I need it to continue 0 -> π -> 2π
        let adjustedAngle = angle >= 0 ? angle : angle + .tau // else turn -π to π
        
        let radiusValue = percentOfRadius * radius
        let ringValue = ringMapping.values.first { $0.contains(radiusValue) }
        
        let groupValue = groupMapping.values.first { $0.contains(adjustedAngle) }
        
        if let ringValue = ringValue, let groupValue = groupValue {
            if let ringIndex = ringMapping.keys(forValue: ringValue).first, let groupIndex = groupMapping.keys(forValue: groupValue).first {
                selectedGameSpace?.fillColor = selectedGameSpace?.color ?? UIColor.clear
                selectedGameSpace = gameSpaces[ringIndex][groupIndex]
                selectedGameSpace?.fillColor = UIColor.white
            }
        }
    }
}
