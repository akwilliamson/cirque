//
//  GamePlayer.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/18/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit
import SpriteKit

protocol AlertDelegate {

    func alert(loser: Player)
}

class GamePlayer {
    
    let player: Player
    let groupColorOne: UIColor
    let groupColorTwo: UIColor
    
    var alertDelegate: AlertDelegate?
    
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
    
    func closeGroupColor(_ groupColor: UIColor) {
        if groupColor == groupColorOne {
            print(player, "group color one closed")
            groupColorOneClosed = true
        }
        if groupColor == groupColorTwo {
            print(player, "group color two closed")
            groupColorTwoClosed = true
        }
    }
    
    private func checkIfLost() {
        if groupColorOneClosed && groupColorTwoClosed {
            alertDelegate?.alert(loser: self.player)
        }
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
}

extension GamePlayer: Equatable {
    
    static func == (lhs: GamePlayer, rhs: GamePlayer) -> Bool {
        return lhs.player == rhs.player
    }
}
