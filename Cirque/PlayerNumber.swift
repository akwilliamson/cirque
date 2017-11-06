//
//  PlayerNumber.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/16/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

enum PlayerNumber {
    
    case one
    case two
    
    mutating func change() {
        switch self {
        case .one: self = .two
        case .two: self = .one
        }
    }
}
