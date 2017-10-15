//
//  SpaceColoring.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/24/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit

protocol SpaceColoring {

    func makeWedgeColors() -> [WedgeColor]
}

extension SpaceColoring {
    
    func makeWedgeColors() -> [WedgeColor] {
        return [.green, .yellow, .orange, .red, .pink, .purple, .blue, .brown]
    }
}
