//
//  GameBoard.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/3/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit
import SpriteKit

final class Board: SKNode {
    
    typealias RangeDict = [Int: ClosedRange<CGFloat>]
    
    let radius: CGFloat            // Percent of superview's smallest side for calculating display size
    var gameSpaces: [[Space]]      // Contains all spaces within the game, grouped by wedge in 2D array
    var wedgeRanges: RangeDict     // The range of each angle within the game board devoted to each group
    var ringRanges: RangeDict      // The range of each width within the game board devoted to each ring
    var gameDelegate: GameDelegate // Delegate for passing game space actions to for handling
    var focusedGameSpace: Space?   // The currently highlighted game space
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ radius: CGFloat, spaces: [[Space]], wedgeRanges: RangeDict, ringRanges: RangeDict, gameDelegate: GameDelegate) {
        self.radius       = radius
        self.gameSpaces   = spaces
        self.wedgeRanges  = wedgeRanges
        self.ringRanges   = ringRanges
        self.gameDelegate = gameDelegate
        super.init()
    }
    
    public func populateSpaces() {
        gameSpaces.forEach { wedge in
            wedge.forEach { space in
                addChild(space)
            }
        }
    }
    
    public func handleTouch(at angle: CGFloat, and distance: CGFloat) {
        guard let gameSpace = focusedGameSpace else { return }
        
        guard let wedge = (wedgeRanges.values.first { $0.contains(angle) }) else { return }
        guard let ring  =  (ringRanges.values.first { $0.contains(radius * distance) }) else { return }
        
        if let wedgeIndex = wedgeRanges.keys(for: wedge).first, let ringIndex = ringRanges.keys(for: ring).first {
            gameDelegate.open(gameSpace)
            focusedGameSpace = gameSpaces[wedgeIndex][ringIndex]
            gameDelegate.highlight(gameSpace)
        }
    }
    
    public func handlePress() {
        guard let gameSpace = focusedGameSpace else { return }
        
        gameDelegate.select(gameSpace) { selected in
            if selected {
                checkWedgeIsAlive(for: gameSpace.wedgeNum)
                checkSqueeze(rotating: .clockwise, for: gameSpace)
                checkSqueeze(rotating: .counterClockwise, for: gameSpace)
            }
        }
    }
    
    private func checkWedgeIsAlive(for wedgeNum: Int) {
        let allSpacesInWedge = gameSpaces[wedgeNum.index]
        let allSpaceStatesInWedge = allSpacesInWedge.map { $0.state }
        
        if !allSpaceStatesInWedge.contains(.open) {
            gameDelegate.close(allSpacesInWedge)
        }
    }
    
    private func checkSqueeze(rotating: Rotation, for space: Space) {
        
        let surroundingWedgeIndex = rotating == .clockwise ? space.wedgeNum.doubleIncremented : space.wedgeNum.doubleDecremented
        let surroundingSpace      = gameSpaces[wrapping: surroundingWedgeIndex][wrapping: space.ringNum.index]
        
        // Player owns surrounding spaces, squeeze in effect
        if surroundingSpace.owner == space.owner {
            
            let sqeezedWedgeIndex = rotating == .clockwise ? space.wedgeNum.incremented : space.wedgeNum.decremented
            let squeezedSpace     = gameSpaces[wrapping: sqeezedWedgeIndex][wrapping: space.ringNum.index]
            
            // Space being squeezed belongs to opponent, reopen
            if squeezedSpace.owner != space.owner && squeezedSpace.owner != nil {
                gameDelegate.revive(squeezedSpace)
            }
        }
    }
}
