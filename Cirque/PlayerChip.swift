//
//  PlayerChip.swift
//  Cirque
//
//  Created by Aaron Williamson on 10/17/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit
import SpriteKit

final class PlayerChip: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(texture: SKTexture?, size: CGSize = CGSize(width: 50, height: 50)) {
        super.init(texture: texture, color: .blue, size: size)
    }
}
