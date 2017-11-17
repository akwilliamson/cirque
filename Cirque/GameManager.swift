//
//  GameManager.swift
//  Cirque
//
//  Created by Aaron Williamson on 11/4/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import Foundation

struct GameManager {
    
    var playerOne: Player
    var playerTwo: Player
    var currentPlayer: PlayerNumber = .one
    var sceneDelegate: SceneDelegate
    
    init(playerOne: Player, playerTwo: Player, sceneDelegate: SceneDelegate) {
        self.playerOne     = playerOne
        self.playerTwo     = playerTwo
        self.sceneDelegate = sceneDelegate
    }
}

extension GameManager: GameDelegate {
    
    func getCurrentPlayer(_ complete: (PlayerNumber) -> Void) {
        complete(currentPlayer)
    }
    
    func open(_ gameSpace: Space) {
        gameSpace.open()
    }
    
    func highlight(_ gameSpace: Space) {
        gameSpace.highlight()
    }
    
    mutating func select(_ gameSpace: Space, complete: (Bool) -> Void) {
        gameSpace.select(for: currentPlayer) { selected in
            if selected {
                currentPlayer.change()
            }
            complete(selected)
        }
    }
    
    func close(_ spaces: [Space]) {
        spaces.forEach { $0.close() }
    }
    
    func revive(_ space: Space) {
        space.revive()
    }
}
