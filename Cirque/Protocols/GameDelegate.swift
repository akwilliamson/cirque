//
//  GameDelegate.swift
//  Cirque
//
//  Created by Aaron Williamson on 7/13/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

/**
 
 Sets the state of a `Space` and handles any completion, e.g. closing a group
 if all group spaces are closed, adding a player chip to a selected space, ending
 the game if both groups are closed for a player, etc.
 
 Conforming Types: CirqueScene
 
**/

protocol GameDelegate {
    
    func getCurrentPlayer(_ complete: (PlayerNumber) -> Void)
    
    func open(_ gameSpace: Space)
    func highlight(_ gameSpace: Space)
    mutating func select(_ gameSpace: Space, complete: (Bool) -> Void)
    func close(_ gameSpaces: [Space])
    func revive(_ gameSpace: Space)
}
