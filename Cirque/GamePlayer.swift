//
//  GamePlayer.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/18/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit
import SpriteKit

struct GamePlayer: Equatable {
    
    var player: CurrentPlayer
    
    init(player: CurrentPlayer) {
        self.player = player
    }
    
    static func == (lhs: GamePlayer, rhs: GamePlayer) -> Bool {
        return lhs.player == rhs.player
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
