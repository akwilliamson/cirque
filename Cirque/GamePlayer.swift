//
//  GamePlayer.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/18/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit
import SpriteKit

class GamePlayer {
    
    let player: Player
    let groupColorOne: UIColor
    let groupColorTwo: UIColor
    
    var gameEndingDelegate: GameEndingDelegate?
    
    var groupColorOneClosed: Bool = false {
        didSet { checkIfLost() }
    }
    
    var groupColorTwoClosed: Bool = false {
        didSet { checkIfLost() }
    }
    
    init(_ player: Player, groupColorOne: UIColor, groupColorTwo: UIColor) {
        self.player         = player
        self.groupColorOne  = groupColorOne
        self.groupColorTwo  = groupColorTwo
    }
    
    func own(_ gameSpace: GameSpace?, switchPlayer: (Bool) -> Void) {
        guard let gameSpace = gameSpace else { return }
        
        if gameSpace.isSelectable {
            gameSpace.owner = self
            switchPlayer(true)
        } else {
            switchPlayer(false)
        }
    }
    
    func closeGroupColor(_ groupColor: UIColor) {
        groupColorOneClosed = groupColor == groupColorOne
        groupColorTwoClosed = groupColor == groupColorTwo
    }
    
    private func checkIfLost() {
        if groupColorOneClosed && groupColorTwoClosed {
            gameEndingDelegate?.alert(loser: player)
        }
    }
}

extension GamePlayer: Equatable {
    
    static func == (lhs: GamePlayer, rhs: GamePlayer) -> Bool {
        return lhs.player == rhs.player
    }
}
