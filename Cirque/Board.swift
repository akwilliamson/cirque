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
    
    let radius: CGFloat              // Percent of superview's smallest side for calculating display size
    var wedgeSpaces: [[Space]]       // Contains all spaces within the game, grouped by wedge in 2D array
    var playerChips: [PlayerChip]    // Contains all the player chips that have been placed on the game board
    var wedgeRanges: RangeDict       // The range of each angle within the game board devoted to each group
    var ringRanges: RangeDict        // The range of each width within the game board devoted to each ring
    var spaceDelegate: SpaceDelegate // Sets the state of spaces within the board during user interaction
    
    var focusedGameSpace: Space?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ radius: CGFloat, spaces: [[Space]], wedgeRanges: RangeDict, ringRanges: RangeDict, spaceDelegate: SpaceDelegate) {
        self.radius        = radius
        self.wedgeSpaces   = spaces
        self.wedgeRanges   = wedgeRanges
        self.ringRanges    = ringRanges
        self.spaceDelegate = spaceDelegate
        self.playerChips   = []
        super.init()
    }
    
    public func populateSpaces() {
        wedgeSpaces.forEach { wedge in
            wedge.forEach { space in
                addChild(space)
            }
        }
    }
    
    /** Highlight a new `Space`, Open the old `Space` **/
    public func handleTouch(at angle: CGFloat, and distance: CGFloat) {
        guard let gameSpace = focusedGameSpace else { return }
        
        let wedge = wedgeRanges.values.first { $0.contains(angle) }
        let ring  =  ringRanges.values.first { $0.contains(radius * distance) }
        
        guard let wedgeNum = wedge, let ringNum = ring else { return }
        
        if let wedgeIndex = wedgeRanges.keys(for: wedgeNum).first, let ringIndex = ringRanges.keys(for: ringNum).first {
            spaceDelegate.open(gameSpace)
            focusedGameSpace = wedgeSpaces[wedgeIndex][ringIndex]
            spaceDelegate.highlight(gameSpace)
        }
    }
    
    public func handlePress() {
        guard let gameSpace = focusedGameSpace else { return }
        
        spaceDelegate.select(gameSpace) { (selected, chip) in
            
            if selected {
                if let chip = chip { addChild(chip) }
                
                checkWedgeIsAlive(for: gameSpace.wedgeNum)
                checkSqueeze(rotating: .clockwise, for: gameSpace)
                checkSqueeze(rotating: .counterClockwise, for: gameSpace)
            }
        }
    }
    
    /** Open a `Space` **/
    private func openSpace() {
        // TODO: Call from somewhere within `handleTouch`
    }
    
    /** Highlight a `Space` **/
    private func highlightSpace() {
        // TODO: Call from somewhere within `handleTouch`
    }
    
    /** Close all `Space`s within a wedge **/
    private func checkWedgeIsAlive(for wedgeNum: Int) {
        let allSpacesInWedge = wedgeSpaces[wedgeNum.index]
        let allSpaceStatesInWedge = allSpacesInWedge.map { $0.state }
        
        if allSpaceStatesInWedge.contains(.open) == false {
            spaceDelegate.close(allSpacesInWedge)
        }
    }
    
    /** Revive a clockwise or counter-clockwise `Space` **/
    private func checkSqueeze(rotating: Rotation, for space: Space) {
        
        let surroundingSpace: Space
        
        switch rotating {
        case .clockwise:        surroundingSpace = wedgeSpaces[wrapping: space.wedgeNum.doubleIncremented][wrapping: space.ringNum.index]
        case .counterClockwise: surroundingSpace = wedgeSpaces[wrapping: space.wedgeNum.doubleDecremented][wrapping: space.ringNum.index]
        }
        
        // Player owns surrounding spaces, squeeze in effect
        if surroundingSpace.owner == space.owner {
            
            let squeezedSpace: Space
            
            switch rotating {
            case .clockwise:        squeezedSpace = wedgeSpaces[wrapping: space.wedgeNum.incremented][wrapping: space.ringNum.index]
            case .counterClockwise: squeezedSpace = wedgeSpaces[wrapping: space.wedgeNum.decremented][wrapping: space.ringNum.index]
            }
            
            // Space being squeezed belongs to opponent, reopen
            if squeezedSpace.owner != space.owner && squeezedSpace.owner != nil {
                spaceDelegate.revive(squeezedSpace)
            }
        }
    }
}
