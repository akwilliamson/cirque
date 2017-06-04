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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as! SKView
        skView.ignoresSiblingOrder = true
        
        let board = Board(container: skView.frame, groups: 8, groupMargin: 0.02, rings: 5, ringMargin: 3)
        let gameScene = GameScene(size: skView.frame.size, board: board)
        
        skView.presentScene(gameScene)
    }
}
