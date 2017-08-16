//
//  GameScene.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/2/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, PointConverting {
    
    fileprivate var player1: GamePlayer
    fileprivate var player2: GamePlayer
    private var gameBoard: GameBoard
    
    fileprivate var currentPlayer: CurrentPlayer
    
    private var touchOrigin: CGPoint?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(size: CGSize, player1: GamePlayer, player2: GamePlayer, gameBoard: GameBoard) {
        self.player1 = player1
        self.player2 = player2
        self.gameBoard = gameBoard
        self.currentPlayer = .player1
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        gameBoard.generateSpaces()
        gameBoard.delegate = self
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
        
        let angle = getAngleBetween(point1: touchOrigin, point2: touchCurrent)
        let distance = getDistanceBetween(point1: touchOrigin, point2: touchCurrent)
        
        gameBoard.highlight(atAngle: angle, atDistance: distance)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchOrigin = nil
    }
    
    func switchPlayers() {
        currentPlayer = currentPlayer == .player1 ? .player2 : .player1
    }
}

extension GameScene: SpaceOwning {
    
    func setState(of gameSpace: GameSpace?) {
        
        switch currentPlayer {
        case .player1:
            player1.own(gameSpace) { shouldSwitch in
                if shouldSwitch { switchPlayers() }
            }
        case .player2:
            player2.own(gameSpace) { shouldSwitch in
                if shouldSwitch { switchPlayers() }
            }
        }
    }
}
