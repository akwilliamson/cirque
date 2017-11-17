//
//  GameViewController.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/2/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit
import SpriteKit

final class GameViewController: UIViewController {
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    lazy var skView: SKView = { return (self.view as! SKView) }()
    
    var playerOne: Player?
    var playerTwo: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        skView.ignoresSiblingOrder = true

        skView.presentScene(makeCirqueScene())
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        skView.scene?.pressesEnded(presses, with: event)
    }
    
    private func makeCirqueScene() -> CirqueScene? {
        guard let playerOne = playerOne, let playerTwo = playerTwo else { return nil }
        
        let gameManager = GameManager(playerOne: playerOne, playerTwo: playerTwo, sceneDelegate: self)
        let gameBoard = makeGameBoard(sizedFor: skView, wedges: 8, rings: 5, gameDelegate: gameManager)
        
        return CirqueScene(view.frame.size, board: gameBoard)
    }
    
    private func makeGameBoard(sizedFor view: SKView, wedges: Int, rings: Int, gameDelegate: GameDelegate) -> Board {
        
        var gameGenerator = GameGenerator(wedges: wedges, rings: rings, container: view.frame)
        let gameBoard = gameGenerator.generateBoard(for: view)
        
        return gameBoard
    }
}

extension GameViewController: SceneDelegate {
    
    func gameEnded(winner: PlayerNumber) {
        print("the winner is...\(winner)")
    }
}
