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
    let groupColorOne: GroupColor
    let groupColorTwo: GroupColor
    
    var gameSettingsDelegate: GameSettingsDelegate?
    
    var groupColorOneClosed: Bool = false {
        didSet {
            checkIfLost()
        }
    }
    
    var groupColorTwoClosed: Bool = false {
        didSet {
            checkIfLost()
        }
    }
    
    init(_ player: Player, groupColorOne: GroupColor, groupColorTwo: GroupColor) {
        self.player         = player
        self.groupColorOne  = groupColorOne
        self.groupColorTwo  = groupColorTwo
    }
    
    func close(_ groupColor: GroupColor) {
        groupColorOneClosed = groupColor == groupColorOne
        groupColorTwoClosed = groupColor == groupColorTwo
    }
    
    private func checkIfLost() {
        if groupColorOneClosed && groupColorTwoClosed {
            gameSettingsDelegate?.alert(loser: player)
        }
    }
}

extension GamePlayer: Equatable {
    
    static func == (lhs: GamePlayer, rhs: GamePlayer) -> Bool {
        return lhs.player == rhs.player
    }
}
