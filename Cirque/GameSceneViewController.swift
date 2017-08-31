//
//  ViewController.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/2/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit
import SpriteKit

class GameSceneViewController: UIViewController {
    
    private var gameScene: GameScene?
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    var playerOne: GamePlayer? {
        didSet { playerOne?.gameEndingDelegate = self }
    }
    var playerTwo: GamePlayer? {
        didSet { playerTwo?.gameEndingDelegate = self }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let skView = view as? SKView else { return }
        skView.ignoresSiblingOrder = true
        
        createGameScene(numberOfPlayers: 2, numberOfGroups: 8, numberOfRings: 5)
        
        skView.presentScene(gameScene)
    }
    
    private func createGameScene(numberOfPlayers: Int, numberOfGroups: Int, numberOfRings: Int) {
        guard let playerOne = playerOne, let playerTwo = playerTwo else { return }
        
        let gameBoard = createGameBoard(numberOfGroups: numberOfGroups, numberOfRings: numberOfRings)
        gameScene = GameScene(size: view.frame.size, playerOne: playerOne, playerTwo: playerTwo, gameBoard: gameBoard)
    }
    
    private func createGameBoard(numberOfGroups: Int, numberOfRings: Int) -> GameBoard {
        return GameBoard(container: view.frame, groups: numberOfGroups, rings: numberOfRings)
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        gameScene?.pressesEnded(presses, with: event)
    }
}

extension GameSceneViewController: GameEndingDelegate {
    
    func alert(loser: Player) {
        
        switch loser {
        case .one:
            winnerLabel.text = "Player 2 won!"
        case .two:
            winnerLabel.text = "Player 1 won!"
        }
        winnerLabel.sizeToFit()
    }
}
