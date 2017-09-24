//
//  GamePlayer.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/18/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit
import SpriteKit

class GamePlayer {
    
    let player: Player
    let groupColorOne: GroupColor
    let groupColorTwo: GroupColor
    
    var groupColorOneClosed: Bool = false
    var groupColorTwoClosed: Bool = false
    
    var playerLost: Bool {
        return groupColorOneClosed && groupColorTwoClosed
    }
    
    init(_ player: Player, groupColorOne: GroupColor, groupColorTwo: GroupColor) {
        self.player         = player
        self.groupColorOne  = groupColorOne
        self.groupColorTwo  = groupColorTwo
    }
    
    func owns(_ closedColor: GroupColor?) -> Bool {
        return groupColorOne == closedColor || groupColorTwo == closedColor
    }
    
    func close(_ groupColor: GroupColor?, complete: (Bool) -> Void) {
        if groupColor == groupColorOne { groupColorOneClosed = true }
        if groupColor == groupColorTwo { groupColorTwoClosed = true }
        complete(playerLost)
    }
}
