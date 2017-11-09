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
    
    var playerOne: Player?
    var playerTwo: Player?
    var cirqueScene: CirqueScene?
    var gameBoard: Board?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let skView = view as? SKView else { return }
        skView.ignoresSiblingOrder = true
        
        cirqueScene = makeCirqueScene()
        gameBoard = makeBoard(sizedFor: (view as! SKView), wedges: 8, rings: 5)
        let gameManager = GameManager(board: gameBoard, playerOne: playerOne!, playerTwo: playerTwo!)

        skView.presentScene(cirqueScene)
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        (view as? SKView)?.scene?.pressesEnded(presses, with: event)
    }
    
    private func makeCirqueScene() -> CirqueScene? {
        
        guard let playerOne = playerOne, let playerTwo = playerTwo else { return nil }
        
        let size  = view.frame.size
        
        let board = makeBoard(sizedFor: (view as! SKView), wedges: wedges, rings: rings)
        
        let gameManager = GameManager(board: board, playerOne: playerOne!, playerTwo: playerTwo!)
        
        return CirqueScene(size, wedges: wedges, rings: rings, playerOne: playerOne, playerTwo: playerTwo, cirqueSceneDelegate: self)
    }
    
    private func makeBoard(sizedFor view: SKView, wedges: Int, rings: Int) -> Board {
        
        var gameGenerator = GameGenerator(wedges: wedges, rings: rings, container: view.frame)
        let board = gameGenerator.generateBoard(for: view)
        
        return Board(board.radius, spaces: board.spaces, wedgeRanges: board.wedgeRanges, ringRanges: board.ringRanges)
    }
}

extension GameViewController: CirqueSceneDelegate {
    
    func gameEnded(winner: PlayerNumber) {
        print("the winner is...\(winner)")
    }
}
