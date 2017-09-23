//
//  GameSpaceColoring.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/24/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit

protocol GameSpaceColoring {
    
    var groupColors: [GroupColor] { get set }
    
    func populateGroupColors()
}

extension GameSpaceColoring where Self: GameSetupViewController {
    
    func populateGroupColors() {
        self.groupColors = [.gold, .lime, .forest, .cyan, .ocean, .royal, .magenta, .fire]
    }
}
