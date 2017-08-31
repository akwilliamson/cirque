//
//  GameColoring.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/24/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit

protocol GameColoring {
    
    var gameColors: [UIColor] { get set }
    
    func populateGameColors()
}

extension GameColoring where Self: GameSetupViewController {
    
    func populateGameColors() {
        let groupColors: [GroupColor] = [.gold, .lime, .forest, .cyan, .ocean, .royal, .magenta, .fire]
        self.gameColors = groupColors.map { $0.color }
    }
}
