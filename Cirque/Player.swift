//
//  Player.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/18/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit
import SpriteKit

final class Player {
    
    let playerNumber: PlayerNumber
    var playerColors: [WedgeColor]
    var aliveColors: [Bool]
    
    var texture: SKTexture {
        switch playerNumber {
        case .one: return SKTexture(imageNamed: "black")
        case .two: return SKTexture(imageNamed: "white")
        }
    }
    
    var didLose: Bool {
        return aliveColors.contains(true) == false
    }
    
    init(_ playerNumber: PlayerNumber, playerColors: [WedgeColor]) {
        self.playerNumber = playerNumber
        self.playerColors = playerColors
        self.aliveColors  = playerColors.map { _ in true }
    }
    
    func close(_ wedgeColor: WedgeColor, complete: (Bool) -> Void) {
        if playerColors.contains(wedgeColor) {
            if let i = playerColors.index(of: wedgeColor) {
                aliveColors[i] = false
            }
        }
        complete(didLose)
    }
}

extension Player: Equatable {
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.playerNumber == rhs.playerNumber
    }
}

