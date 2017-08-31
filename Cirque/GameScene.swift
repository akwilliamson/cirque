//
//  GameScene.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/2/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, PointConverting {
    
    private var gameBoard: GameBoard
    fileprivate var playerOne: GamePlayer
    fileprivate var playerTwo: GamePlayer
    fileprivate var currentPlayer: GamePlayer
    
    private var touchOrigin: CGPoint?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(size: CGSize, playerOne: GamePlayer, playerTwo: GamePlayer, gameBoard: GameBoard) {
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        self.currentPlayer = playerOne
        self.gameBoard = gameBoard
        super.init(size: size)
        self.gameBoard.gamePlayerDelegate = self
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
        guard let touchOrigin = touchOrigin else { return }
        guard let touchCurrent = touches.first?.location(in: self) else {
            return
        }
        
        let angle = getAngleBetween(point1: touchOrigin, point2: touchCurrent)
        let distance = getDistanceBetween(point1: touchOrigin, point2: touchCurrent)
        
        gameBoard.highlight(atAngle: angle, atDistance: distance)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchOrigin = nil
    }
}

extension GameScene: GamePlayerDelegate {
    
    func own(_ gameSpace: GameSpace?) {
        currentPlayer.own(gameSpace) { endPlayerTurn in
            if endPlayerTurn {
                currentPlayer = currentPlayer == playerOne ? playerTwo : playerOne
            }
        }
    }
}
