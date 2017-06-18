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
    
    var gameScene: SKScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createGame(numberOfGroups: 8, numberOfRings: 5)
        
        if let skView = view as? SKView {
            skView.ignoresSiblingOrder = true
            skView.presentScene(gameScene)
        }
    }
    
    private func createGame(numberOfGroups: Int, numberOfRings: Int) {
        let gameBoard = GameBoard(container: view.frame, groups: numberOfGroups, rings: numberOfRings)
        gameScene = GameScene(size: view.frame.size, gameBoard: gameBoard)
    }
}
