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
        
        let cirqueScene = CirqueScene(size: skView.frame.size)
        cirqueScene.scaleMode = .aspectFill
        
        skView.presentScene(cirqueScene)
    }
}

