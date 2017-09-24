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
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    var playerOne: GamePlayer?
    var playerTwo: GamePlayer?
    var gameScene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let skView = view as? SKView else { return }
        skView.ignoresSiblingOrder = true
        
        gameScene = createGameScene(groupNum: 8, ringNum: 5)
        gameScene?.gameSceneDelegate = self
        skView.presentScene(gameScene)
    }
    
    private func createGameScene(groupNum: Int, ringNum: Int) -> GameScene? {
        
        let gameBoard = createGameBoard(groupNum: groupNum, ringNum: ringNum)
        
        if let playerOne = playerOne, let playerTwo = playerTwo {
            return GameScene(size: view.frame.size, gameBoard: gameBoard, playerOne: playerOne, playerTwo: playerTwo)
        } else {
            return nil
        }
    }
    
    private func createGameBoard(groupNum: Int, ringNum: Int) -> GameBoard {
        return GameBoard(container: view.frame, groups: groupNum, rings: ringNum)
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        (view as? SKView)?.scene?.pressesEnded(presses, with: event)
    }
}

extension GameSceneViewController: GameSceneDelegate {
    
    func gameEnded(winner: Player) {
        print("the winner is...\(winner)")
    }
}
