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
    
    typealias RangeDict = [Int: ClosedRange<CGFloat>]
    
    let radius: CGFloat            // % of superview's smallest side
    var wedgeSpaces: [[GameSpace]] // Contains all spaces, grouped by wedge
    var wedgeRanges: RangeDict     // The range of each angle within the game board devoted to each group
    var ringRanges: RangeDict      // The range of each width within the game board devoted to each ring
    
    var focusedGameSpace: GameSpace?
    var gameSpaceDelegate: SpaceSelecting?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(radius: CGFloat, spaces: [[GameSpace]], wedgeRanges: RangeDict, ringRanges: RangeDict) {
        self.radius      = radius
        self.wedgeSpaces = spaces
        self.wedgeRanges = wedgeRanges
        self.ringRanges  = ringRanges
        super.init()
    }
    
    func populateSpaces() {
        wedgeSpaces.forEach { wedge in
            wedge.forEach { space in
                addChild(space)
            }
        }
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        selectGameSpace()
    }
    
    private func selectGameSpace() {
        guard let gameSpace = focusedGameSpace else { return }
        
        gameSpaceDelegate?.select(focusedGameSpace) { selected in
            if selected {
                checkGroupIsAlive(for: gameSpace.wedgeNum)
                checkSqueeze(rotating: .clockwise, for: gameSpace)
                checkSqueeze(rotating: .counterClockwise, for: gameSpace)
            }
        }
    }
    
    private func checkGroupIsAlive(for groupNum: Int) {
        let groupGameSpaces = wedgeSpaces[groupNum.index]
        let groupGameSpaceStates = groupGameSpaces.map { $0.state }
        
        if !groupGameSpaceStates.contains(.open) {
            gameSpaceDelegate?.close(groupGameSpaces)
        }
    }
    
    private func checkSqueeze(rotating: Rotation, for space: GameSpace) {
        
        let surroundingSpace: GameSpace
        
        switch rotating {
        case .clockwise:
            surroundingSpace = wedgeSpaces[wrapping: space.wedgeNum.doubleIncremented][wrapping: space.ringNum.index]
        case .counterClockwise:
            surroundingSpace = wedgeSpaces[wrapping: space.wedgeNum.doubleDecremented][wrapping: space.ringNum.index]
        }
        
        // Player owns surrounding spaces, squeeze in effect
        if surroundingSpace.owner == space.owner {
            
            let squeezedSpace: GameSpace
            
            switch rotating {
            case .clockwise:
                squeezedSpace = wedgeSpaces[wrapping: space.wedgeNum.incremented][wrapping: space.ringNum.index]
            case .counterClockwise:
                squeezedSpace = wedgeSpaces[wrapping: space.wedgeNum.decremented][wrapping: space.ringNum.index]
            }
            
            // Space being squeezed belongs to opponent, reopen
            if squeezedSpace.owner != space.owner && squeezedSpace.owner != nil {
                squeezedSpace.reopen()
            }
        }
    }
}

extension GameBoard: SpaceHighlighting {
    
    func highlightSpace(at angle: CGFloat, and distance: CGFloat) {
        
        let groupNum = wedgeRanges.values.first { $0.contains(angle) }
        let ringNum  =  ringRanges.values.first { $0.contains(radius * distance) }
        
        guard let group = groupNum, let ring = ringNum else { return }
        
        if let wedgeIndex = wedgeRanges.keys(for: group).first, let ringIndex = ringRanges.keys(for: ring).first {
            focusedGameSpace?.open()
            focusedGameSpace = wedgeSpaces[wedgeIndex][ringIndex]
            focusedGameSpace?.highlight()
        }
    }
}
