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
    var gameDelegate: GameDelegate
    
    var currentPlayer: PlayerNumber = .one
    
    init(board: Board, playerOne: Player, playerTwo: Player, gameDelegate: GameDelegate) {
        self.board        = board
        self.playerOne    = playerOne
        self.playerTwo    = playerTwo
        self.gameDelegate = gameDelegate
    }
    
    mutating func swapPlayers() {
        currentPlayer.change()
    }
}

extension GameManager: GameDelegate {
    
    func getCurrentPlayer(_ complete: (PlayerNumber) -> Void) {
        complete(currentPlayer)
    }
    
    func select(_ gameSpace: Space, complete: (Bool, PlayerChip?) -> Void) {
        
        gameSpace.select(for: <#T##PlayerNumber#>, complete: <#T##(Bool) -> Void#>)
        
        let chip = PlayerChip(texture: currentPlayer.texture, wedgeNum: gameSpace.wedgeNum, ringNum: gameSpace.ringNum)
        chip.position = gameSpace.point
        chip.zPosition = 200
        addChild(chip)
    }
    
    func close(_ spaces: [Space]) {
        
    }
    
    func revive(_ space: Space) {
        
    }
}
