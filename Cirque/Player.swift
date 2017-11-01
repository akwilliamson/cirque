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
    let wedgeColorOne: WedgeColor
    let wedgeColorTwo: WedgeColor
    
    var wedgeColorOneClosed: Bool = false
    var wedgeColorTwoClosed: Bool = false
    
    var playerLost: Bool {
        return wedgeColorOneClosed && wedgeColorTwoClosed
    }
    
    init(_ playerNumber: PlayerNumber, wedgeColorOne: WedgeColor, wedgeColorTwo: WedgeColor) {
        self.playerNumber   = playerNumber
        self.wedgeColorOne  = wedgeColorOne
        self.wedgeColorTwo  = wedgeColorTwo
    }
    
    func owns(_ closedColor: WedgeColor?) -> Bool {
        return wedgeColorOne == closedColor || wedgeColorTwo == closedColor
    }
    
    func close(_ wedgeColor: WedgeColor?, complete: (Bool) -> Void) {
        if wedgeColor == wedgeColorOne { wedgeColorOneClosed = true }
        if wedgeColor == wedgeColorTwo { wedgeColorTwoClosed = true }
        complete(playerLost)
    }
}

extension Player: Equatable {
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.playerNumber == rhs.playerNumber
    }
}

