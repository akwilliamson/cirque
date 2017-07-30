//
//  ViewController.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/2/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    private var gameScene: SKScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let skView = view as? SKView else { return }
        skView.ignoresSiblingOrder = true
        
        createGameScene(numberOfPlayers: 2, numberOfGroups: 8, numberOfRings: 5)
        skView.presentScene(gameScene)
    }
    
    private func createGameScene(numberOfPlayers: Int, numberOfGroups: Int, numberOfRings: Int) {
        
        let player1 = GamePlayer(color: .white)
        let player2 = GamePlayer(color: .black)
        let gameBoard = createGameBoard(numberOfGroups: numberOfGroups, numberOfRings: numberOfRings)
        
        gameScene = GameScene(size: view.frame.size, player1: player1, player2: player2, gameBoard: gameBoard)
    }
    
    private func createGameBoard(numberOfGroups: Int, numberOfRings: Int) -> GameBoard {
        return GameBoard(container: view.frame, groups: numberOfGroups, rings: numberOfRings)
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        gameScene?.pressesEnded(presses, with: event)
    }
}
