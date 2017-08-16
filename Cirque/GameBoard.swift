//
//  GameBoard.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/3/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit
import SpriteKit

class GameBoard: SKNode {
    
    let container: CGRect
    let center: CGPoint
    let radius: CGFloat
    let groups: Int
    let rings: Int
    
    // The spacing between each concentric ring. An arbitrary value
    let ringMargin: CGFloat = 5
    // The percentage of the radius devoted to the open center of the game board. An arbitrary value
    let openCenterPercentageOfRadius: CGFloat = 0.1
    
    var gameSpaces = [[GameSpace]]()
    var groupMapping = [Int: ClosedRange<CGFloat>]()
    var ringMapping = [Int: ClosedRange<CGFloat>]()
    
    var focusedGameSpace: GameSpace?
    
    var lengthForSpace: CGFloat { return .tau/groups.cg }
    var widthForSpace:  CGFloat { return radius/rings.cg - ringMargin }
    
    var delegate: SpaceOwning?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(container: CGRect, groups: Int, rings: Int) {
        self.container = container
        self.center    = container.center
        self.radius    = container.radius(0.4) // percentage of superview's smallest side length
        self.groups    = groups
        self.rings     = rings
        super.init()
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        delegate?.setState(of: focusedGameSpace)
        guard let selectedGroupNum = focusedGameSpace?.groupNum, let selectedRingNum = focusedGameSpace?.ringNum else { return }
        
        let gameSpacesInGroup = gameSpaces[selectedGroupNum.index]
        let gameSpaceStates = gameSpacesInGroup.map { $0.state }
        
        if !gameSpaceStates.contains(.open) {
            gameSpacesInGroup.forEach { $0.close() }
            return
        }
        
        // Check if other 4 game spaces in the group are selected. If so, close the whole group.
        
        let doubleClockwiseSpace = gameSpaces[wrapping: selectedGroupNum.incremented+1][wrapping: selectedRingNum.index]
        let doubleCounterclockwiseSpace = gameSpaces[wrapping: selectedGroupNum.decremented-1][wrapping: selectedRingNum.index]
        
        if doubleClockwiseSpace.owner == focusedGameSpace?.owner && doubleClockwiseSpace.state == .selected {
            let clockwiseSpace = gameSpaces[wrapping: selectedGroupNum.incremented][wrapping: selectedRingNum.index]
            if clockwiseSpace.owner != focusedGameSpace?.owner && clockwiseSpace.state != .closed {
                clockwiseSpace.clearOwner()
            }
        }
        
        if doubleCounterclockwiseSpace.owner == focusedGameSpace?.owner && doubleCounterclockwiseSpace.state == .selected {
            let counterclockwiseSpace = gameSpaces[wrapping: selectedGroupNum.decremented][wrapping: selectedRingNum.index]
            if counterclockwiseSpace.owner != focusedGameSpace?.owner && counterclockwiseSpace.state != .closed {
                counterclockwiseSpace.clearOwner()
            }
        }
    }
    
    func generateSpaces() {
        
        var gameSpaceShaper = GameSpaceShaper(center: center, length: lengthForSpace, width: widthForSpace, startRadius: radius)
        
        for groupNum in 1...groups {
            gameSpaces.append(Array())
            groupMapping[groupNum.index] = (gameSpaceShaper.startAngle...gameSpaceShaper.endAngle)
            
            for ringNum in 1...rings {
                if ringMapping[ringNum.index] == nil {
                    ringMapping[ringNum.index] = (gameSpaceShaper.endRadius...gameSpaceShaper.startRadius)
                }
                let gameSpace = GameSpace(path: gameSpaceShaper.path, groupNum: groupNum, ringNum: ringNum)
                gameSpaces[groupNum.index].append(gameSpace)
                addChild(gameSpace)
                gameSpaceShaper.startRadius = incrementStartRadiusFor(ringNum.cg)
            }
            gameSpaceShaper.startRadius = radius
            gameSpaceShaper.startAngle = incrementStartAngleFor(groupNum.cg)
        }
    }
    
    private func incrementStartAngleFor(_ groupNum: CGFloat) -> CGFloat {
        return groupNum/groups.cg * .tau // 1/X % of circumference
    }
    
    private func incrementStartRadiusFor(_ ringNum: CGFloat) -> CGFloat {
        let percentageOfRadiusForRing = 1 - ringNum/rings.cg
        let percentageOfShrinkForRing = openCenterPercentageOfRadius * ringNum/rings.cg
        return radius * (percentageOfRadiusForRing + percentageOfShrinkForRing)
    }
}

extension GameBoard: Highlighting {
    
    func highlight(atAngle angle: CGFloat, atDistance distance: CGFloat) {
        // Reopen previous game space for selection
        focusedGameSpace?.reopen()
        
        let radialDistance = distance * radius
        
        let groupValue = groupMapping.values.first { $0.contains(angle) }
        let ringValue  = ringMapping.values.first  { $0.contains(radialDistance) }
        
        if let groupValue = groupValue, let ringValue = ringValue {
            if let groupIndex = groupMapping.keys(forValue: groupValue).first, let ringIndex = ringMapping.keys(forValue: ringValue).first {
                focusedGameSpace = gameSpaces[groupIndex][ringIndex]
                focusedGameSpace?.highlight()
            }
        }
    }
}
