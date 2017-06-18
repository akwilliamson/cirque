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
    
    var touchStart: CGPoint?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(size: CGSize, board: Board) {
        self.board = board
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        board.generateSpaces()
        addChild(board)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        
        touchStart = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touchStart = touchStart else { return }
        guard let touchCurrent = touches.first else { return }
        
        let diffX = touchCurrent.location(in: self).x - touchStart.x
        let diffY = touchCurrent.location(in: self).y - touchStart.y
        
        let distanceBetweenTouches = hypot(diffX, diffY)
        // 600.0 is the scaled down distance to change travel required on Apple TV Remote
        let percentTraveled = min(distanceBetweenTouches/600.0, 1.0)
    
        let radians = atan2(diffY, diffX)
        board.select(atAngle: radians, percentOfRadius: percentTraveled)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchStart = nil
    }
}
