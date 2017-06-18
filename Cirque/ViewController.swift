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
        
        let board = Board(container: view.frame, groups: 8, rings: 5)
        gameScene = GameScene(size: view.frame.size, board: board)
        
        if let skView = view as? SKView {
            skView.ignoresSiblingOrder = true
            skView.presentScene(gameScene)
        }
    }
}
