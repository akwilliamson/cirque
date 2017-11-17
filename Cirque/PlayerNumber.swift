//
//  PlayerNumber.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/16/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import SpriteKit

enum PlayerNumber {
    
    case one
    case two
    
    var texture: SKTexture {
        switch self {
        case .one: return SKTexture(imageNamed: "black")
        case .two: return SKTexture(imageNamed: "white")
        }
    }
    
    mutating func change() {
        switch self {
        case .one: self = .two
        case .two: self = .one
        }
    }
}
