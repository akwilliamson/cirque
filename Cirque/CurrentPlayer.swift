//
//  CurrentPlayer.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/16/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit

enum CurrentPlayer {
    
    case player1
    case player2
    
    // The color that displays ownership of a game piece for a given player
    var color: UIColor {
        switch self {
        case .player1: return .white
        case .player2: return .black
        }
    }
}
