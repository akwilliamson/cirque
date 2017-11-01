//
//  CirqueSceneDelegate.swift
//  Cirque
//
//  Created by Aaron Williamson on 9/23/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

/**
 
 Handles the game winner delegated from the `CirqueScene` after closing the last group
 for the opponent.
 
 Conforming Types: GameViewController
 
**/

protocol CirqueSceneDelegate: class {
    
    func gameEnded(winner: PlayerNumber)
}
