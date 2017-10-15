//
//  GameScene.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/2/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SpaceMapping {
    
    private var gameBoard: GameBoard
    fileprivate var playerOne: GamePlayer
    fileprivate var playerTwo: GamePlayer
    fileprivate var currentPlayer: Player
    
    private var touchOrigin: CGPoint?

    var gameSceneDelegate: GameSceneDelegate?
    
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
        addChild(gameBoard)
        gameBoard.populateSpaces()
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
        
        gameBoard.highlightSpace(at: angle, and: distance)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchOrigin = nil
    }
}

extension GameScene: SpaceSelecting {
    
    func select(_ gameSpace: GameSpace?, complete: (Bool) -> Void) {
        
        gameSpace?.set(owner: currentPlayer) { endTurn in
            if endTurn { swapPlayers() }
            complete(endTurn)
        }
    }
    
    func close(_ gameSpaces: [GameSpace]) {
        
        gameSpaces.forEach { $0.close() }
        
        let wedgeColor = gameSpaces.first?.wedgeColor
        
        if playerOne.owns(wedgeColor) {
            playerOne.close(wedgeColor) { playerOneLost in
                if playerOneLost { gameSceneDelegate?.gameEnded(winner: .two) }
            }
        }
        if playerTwo.owns(wedgeColor) {
            playerTwo.close(wedgeColor) { playerTwoLost in
                if playerTwoLost { gameSceneDelegate?.gameEnded(winner: .one) }
            }
        }
    }
    
    private func swapPlayers() {
        currentPlayer = currentPlayer == .one ? .two : .one
    }
}
