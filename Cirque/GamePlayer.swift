//
//  GamePlayer.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/18/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit
import SpriteKit

struct GamePlayer: Equatable {
    
    let player: CurrentPlayer
    let colorOne: UIColor
    let colorTwo: UIColor
    
    var colorOneClosed: Bool = false {
        didSet {
            if colorOneClosed && colorTwoClosed {
                print("PLAYER \(player) LOST")
            }
        }
    }
    var colorTwoClosed: Bool = false {
        didSet {
            if colorOneClosed && colorTwoClosed {
                print("PLAYER \(player) LOST")
            }
        }
    }
    
    init(player: CurrentPlayer, colorOne: UIColor, colorTwo: UIColor) {
        self.player   = player
        self.colorOne = colorOne
        self.colorTwo = colorTwo
    }
    
    static func == (lhs: GamePlayer, rhs: GamePlayer) -> Bool {
        return lhs.player == rhs.player
    }
    
    mutating func close(_ color: UIColor) {
        
        if color == colorOne {
            colorOneClosed = true
        } else if color == colorTwo {
            colorTwoClosed = true
        }
    }
    
    func own(_ gameSpace: GameSpace?, switchPlayer: (Bool) -> Void) {
        guard let gameSpace = gameSpace else { return }
        if gameSpace.isSelectable {
            gameSpace.owner = self
            switchPlayer(true)
        } else {
            switchPlayer(false)
        }
    }
}
