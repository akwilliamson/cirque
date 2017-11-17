//
//  CirqueScene.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/2/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import SpriteKit

final class CirqueScene: SKScene {
    
    var board: Board
    
    private var touchOrigin: CGPoint?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(_ size: CGSize, board: Board) {
        self.board = board
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        addChild(board)
        board.populateSpaces() // TODO: Animate
    }
    
// MARK: Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchOrigin = touches.first?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchOrigin = touchOrigin, let touchCurrent = touches.first?.location(in: self) else { return }
        
        let angle    = getAngle(touchOrigin, and: touchCurrent)
        let distance = getDistance(touchOrigin, and: touchCurrent)
        
        board.handleTouch(at: angle, and: distance)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchOrigin = nil
    }
    
// MARK: Presses
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        board.handlePress()
    }
}

extension CirqueScene: TouchMapping {
    
    fileprivate func getAngle(_ touchOrigin: CGPoint, and touchCurrent: CGPoint) -> CGFloat {
        return angleBetween(touchOrigin, and: touchCurrent)
    }
    
    fileprivate func getDistance(_ touchOrigin: CGPoint, and touchCurrent: CGPoint) -> CGFloat {
        return distanceBetween(touchOrigin, and: touchCurrent)
    }
}
