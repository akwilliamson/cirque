//
//  GameManager.swift
//  Cirque
//
//  Created by Aaron Williamson on 11/4/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import Foundation

struct GameManager {
    
    var board: Board
    var playerOne: Player
    var playerTwo: Player
    
    var currentPlayer: PlayerNumber = .one
    
    func getCurrentPlayer(_ complete: (PlayerNumber) -> Void) {
        complete(currentPlayer)
    }
    
    mutating func swapPlayers() {
        currentPlayer.change()
    }
}
