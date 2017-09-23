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
    
    var playerOne: GamePlayer? {
        didSet { playerOne?.gameSettingsDelegate = self }
    }
    var playerTwo: GamePlayer? {
        didSet { playerTwo?.gameSettingsDelegate = self }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let skView = view as? SKView else { return }
        skView.ignoresSiblingOrder = true
        
        createGameScene(playerNum: 2, groupNum: 8, ringNum: 5) { gameScene in
            skView.presentScene(gameScene)
        }
    }
    
    private func createGameScene(playerNum: Int, groupNum: Int, ringNum: Int, complete: (GameScene) -> Void) {
        
        let gameBoard = createGameBoard(groupNum: groupNum, ringNum: ringNum)
        
        if let playerOne = playerOne, let playerTwo = playerTwo {
            complete(GameScene(size: view.frame.size, gameBoard: gameBoard, playerOne: playerOne, playerTwo: playerTwo))
        }
    }
    
    private func createGameBoard(groupNum: Int, ringNum: Int) -> GameBoard {
        return GameBoard(container: view.frame, groups: groupNum, rings: ringNum)
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        (view as? SKView)?.scene?.pressesEnded(presses, with: event)
    }
}

extension GameSceneViewController: GameSettingsDelegate {
    
    func alert(loser: Player) {
        
        switch loser {
        case .one: winnerLabel.text = "Player 2 won!"
        case .two: winnerLabel.text = "Player 1 won!"
        }
        winnerLabel.sizeToFit()
    }
}
