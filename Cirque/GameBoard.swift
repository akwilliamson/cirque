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
    
    // Spacing between each concentric ring. Arbitrary value
    let ringMargin: CGFloat = 5
    // % of the radius devoted to the open center of the game board. Arbitrary value
    let openCenterPercentageOfRadius: CGFloat = 0.1
    
    var gameSpaces = [[GameSpace]]()
    var groupMapping = [Int: ClosedRange<CGFloat>]()
    var ringMapping = [Int: ClosedRange<CGFloat>]()
    
    var focusedGameSpace: GameSpace?
    
    var lengthForSpace: CGFloat { return .tau/groups.cg }
    var widthForSpace:  CGFloat { return radius/rings.cg - ringMargin }
    
    var gameSpaceDelegate: GameSpaceSelecting?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(container: CGRect, groups: Int, rings: Int) {
        self.container = container
        self.center    = container.center
        self.radius    = container.radius(0.4) // % of superview's smallest side length. Arbitrary value
        self.groups    = groups
        self.rings     = rings
        super.init()
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        guard let gameSpace = focusedGameSpace else { return }
        
        gameSpaceDelegate?.select(gameSpace) { selected in
            if selected {
                let groupNum = gameSpace.groupNum
                let ringNum  = gameSpace.ringNum
                checkGroupAliveState(for: groupNum)
                checkClockwiseSandwich(gameSpace, groupNum: groupNum, ringNum: ringNum)
                checkCounterClockwiseSandwich(gameSpace, groupNum: groupNum, ringNum: ringNum)
            } else {
                return
            }
        }
    }
    
    private func checkGroupAliveState(for groupNum: Int) {
        let groupGameSpaces = gameSpaces[groupNum.index]
        let groupGameSpaceStates = groupGameSpaces.map { $0.state }
        
        if groupGameSpaceStates.contains(.open) == false {
            groupGameSpaces.forEach { $0.close() }
        }
    }
    
    private func checkClockwiseSandwich(_ selectedSpace: GameSpace, groupNum: Int, ringNum: Int) {
        let clockwiseSpace       = gameSpaces[wrapping: groupNum.incremented]      [wrapping: ringNum.index]
        let doubleClockwiseSpace = gameSpaces[wrapping: groupNum.doubleIncremented][wrapping: ringNum.index]
        
        if doubleClockwiseSpace.owner == selectedSpace.owner { // Player owns a clockwise sandwish
            if clockwiseSpace.owner != nil && clockwiseSpace.owner != selectedSpace.owner {
                clockwiseSpace.reopen()
            }
        }
    }
    
    private func checkCounterClockwiseSandwich(_ selectedSpace: GameSpace, groupNum: Int, ringNum: Int) {
        let counterClockwiseSpace       = gameSpaces[wrapping: groupNum.decremented]      [wrapping: ringNum.index]
        let doubleCounterClockwiseSpace = gameSpaces[wrapping: groupNum.doubleDecremented][wrapping: ringNum.index]
        
        if doubleCounterClockwiseSpace.owner == selectedSpace.owner { // Player owns a counter-clockwise sandwish
            if counterClockwiseSpace.owner != nil && counterClockwiseSpace.owner != selectedSpace.owner {
                counterClockwiseSpace.reopen()
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

extension GameBoard: GameSpaceHighlighting {
    
    func highlightGameSpace(at angle: CGFloat, and distance: CGFloat) {
        
        let groupNum = groupMapping.values.first { $0.contains(angle) }
        let ringNum  =  ringMapping.values.first { $0.contains(radius * distance) }
        
        guard let group = groupNum, let ring = ringNum else { return }
        
        if let groupIndex = groupMapping.keys(for: group).first, let ringIndex = ringMapping.keys(for: ring).first {
            focusedGameSpace?.open()
            focusedGameSpace = gameSpaces[groupIndex][ringIndex]
            focusedGameSpace?.highlight()
        }
    }
}
