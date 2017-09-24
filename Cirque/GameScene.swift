//
//  GameScene.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/2/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, GameSpaceConverting {
    
    private var gameBoard: GameBoard
    fileprivate var playerOne: GamePlayer
    fileprivate var playerTwo: GamePlayer
    fileprivate var currentPlayer: Player
    
    private var touchOrigin: CGPoint?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(size: CGSize, gameBoard: GameBoard, playerOne: GamePlayer, playerTwo: GamePlayer) {
        self.gameBoard = gameBoard
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        self.currentPlayer = .one
        super.init(size: size)
        self.gameBoard.gameSpaceDelegate = self
    }
    
    override func didMove(to view: SKView) {
        gameBoard.generateSpaces()
        addChild(gameBoard)
    }
    
// MARK: Presses
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        gameBoard.pressesEnded(presses, with: event)
    }
    
// MARK: Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchOrigin = touches.first?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchOrigin = touchOrigin, let touchCurrent = touches.first?.location(in: self) else { return }
        
        let angle    = angleBetween(touchOrigin,    and: touchCurrent)
        let distance = distanceBetween(touchOrigin, and: touchCurrent)
        
        gameBoard.highlightGameSpace(at: angle, and: distance)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchOrigin = nil
    }
}

extension GameScene: GameSpaceSelecting {
    
    func select(_ gameSpace: GameSpace?, complete: (Bool) -> Void) {
        gameSpace?.set(owner: currentPlayer) { endTurn in
            if endTurn { swapPlayers() }
            complete(endTurn)
        }
    }
    
    private func swapPlayers() {
        currentPlayer = currentPlayer == .one ? .two : .one
    }
}
