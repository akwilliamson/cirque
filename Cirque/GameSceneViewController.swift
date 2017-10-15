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
        
        gameScene = createGameScene(wedges: 8, rings: 5)
        gameScene?.gameSceneDelegate = self
        skView.presentScene(gameScene)
    }
    
    private func createGameScene(wedges: Int, rings: Int) -> GameScene? {
        
        let gameBoard = createGameBoard(wedges: wedges, rings: rings)
        
        if let playerOne = playerOne, let playerTwo = playerTwo {
            return GameScene(size: view.frame.size, gameBoard: gameBoard, playerOne: playerOne, playerTwo: playerTwo)
        } else {
            return nil
        }
    }
    
    private func createGameBoard(wedges: Int, rings: Int) -> GameBoard {
        
        var gameCreator = GameSpaceCreator(wedges: wedges, rings: rings, container: view.frame)
        
        let game = gameCreator.generateGame(in: view as! SKView)
        
        return GameBoard(radius: gameCreator.radius, spaces: game.spaces, wedgeRanges: game.wedgeRanges, ringRanges: game.ringRanges)
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
