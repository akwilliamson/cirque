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
    
    let number: PlayerNumber
    var colors: [WedgeColor]
    var aliveColors: [Bool]
    
    var didLose: Bool {
        return !aliveColors.contains(true)
    }
    
    init(_ number: PlayerNumber, colors: [WedgeColor]) {
        self.number = number
        self.colors = colors
        self.aliveColors = colors.map { _ in true }
    }
    
    func close(_ wedgeColor: WedgeColor, complete: (Bool) -> Void) {
        if colors.contains(wedgeColor) {
            if let i = colors.index(of: wedgeColor) {
                aliveColors[i] = false
            }
        }
        complete(didLose)
    }
}

extension Player: Equatable {
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.number == rhs.number
    }
}

