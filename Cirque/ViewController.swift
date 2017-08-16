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
    
    @IBOutlet weak var playerOneColorOneView: UIView!
    @IBOutlet weak var playerOneColorTwoView: UIView!
    @IBOutlet weak var playerOneShowColorsButton: UIButton!
    
    @IBOutlet weak var playerTwoColorOneView: UIView!
    @IBOutlet weak var playerTwoColorTwoView: UIView!
    @IBOutlet weak var playerTwoShowColorsButton: UIButton!
    
    var playerOne: GamePlayer?
    var playerTwo: GamePlayer?
    
    var playerOneColorOne: UIColor?
    var playerOneColorTwo: UIColor?
    var playerTwoColorOne: UIColor?
    var playerTwoColorTwo: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let skView = view as? SKView else { return }
        skView.ignoresSiblingOrder = true
        
        playerOneColorOneView.backgroundColor = playerOneColorOne
        playerOneColorTwoView.backgroundColor = playerOneColorTwo
        playerTwoColorOneView.backgroundColor = playerTwoColorOne
        playerTwoColorTwoView.backgroundColor = playerTwoColorTwo
        
        createGameScene(numberOfPlayers: 2, numberOfGroups: 8, numberOfRings: 5)
        skView.presentScene(gameScene)
    }
    
    @IBAction func playerOneShowColorsPressed(_ sender: UIButton) {
        playerOneColorOneView.isHidden = !playerOneColorOneView.isHidden
        playerOneColorTwoView.isHidden = !playerOneColorTwoView.isHidden
    }
    
    @IBAction func playerTwoShowColorsPressed(_ sender: UIButton) {
        playerTwoColorOneView.isHidden = !playerTwoColorOneView.isHidden
        playerTwoColorTwoView.isHidden = !playerTwoColorTwoView.isHidden
    }
    
    private func createGameScene(numberOfPlayers: Int, numberOfGroups: Int, numberOfRings: Int) {
        let gameBoard = createGameBoard(numberOfGroups: numberOfGroups, numberOfRings: numberOfRings)
        
        if let playerOne = playerOne, let playerTwo = playerTwo {
            gameScene = GameScene(size: view.frame.size, player1: playerOne, player2: playerTwo, gameBoard: gameBoard)
        }
    }
    
    private func createGameBoard(numberOfGroups: Int, numberOfRings: Int) -> GameBoard {
        return GameBoard(container: view.frame, groups: numberOfGroups, rings: numberOfRings)
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        gameScene?.pressesEnded(presses, with: event)
    }
}
