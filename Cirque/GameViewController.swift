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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let skView = view as? SKView else { return }
        skView.ignoresSiblingOrder = true
        
        cirqueScene = createCirqueScene(wedges: 8, rings: 5)

        skView.presentScene(cirqueScene)
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        (view as? SKView)?.scene?.pressesEnded(presses, with: event)
    }
    
    private func createCirqueScene(wedges: Int, rings: Int) -> CirqueScene? {
        
        guard let playerOne = playerOne, let playerTwo = playerTwo else { return nil }
        
        let size  = view.frame.size
        
        return CirqueScene(size, wedges: wedges, rings: rings, playerOne: playerOne, playerTwo: playerTwo, cirqueSceneDelegate: self)
    }
}

extension GameViewController: CirqueSceneDelegate {
    
    func gameEnded(winner: PlayerNumber) {
        print("the winner is...\(winner)")
    }
}
