//
//  GameScene.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/2/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var board: Board

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(size: CGSize, board: Board) {
        self.board = board
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        board.generateSpaces()
        board.isUserInteractionEnabled = true
        addChild(board)
    }
}
