//
//  CurrentPlayer.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/16/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit

enum Player {
    
    case one
    case two
    
    var name: String {
        switch self {
        case .one: return "Player 1"
        case .two: return "Player 2"
        }
    }
    
    var color: UIColor {
        switch self {
        case .one: return .black
        case .two: return .white
        }
    }
}
