//
//  GamePlayer.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/18/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit
import SpriteKit

struct GamePlayer {
    
    var color: UIColor
    
    init(color: UIColor) {
        self.color = color
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
