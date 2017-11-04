//
//  CirqueScene.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/2/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import SpriteKit

final class CirqueScene: SKScene {
    
    private var wedges: Int
    private var rings: Int
    fileprivate var board: Board?
    fileprivate var playerOne: Player
    fileprivate var playerTwo: Player
    fileprivate var cirqueSceneDelegate: CirqueSceneDelegate
    
    fileprivate var currentPlayerNumber: PlayerNumber = .one
    
    private var touchOrigin: CGPoint?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(_ size: CGSize, wedges: Int, rings: Int, playerOne: Player, playerTwo: Player, cirqueSceneDelegate: CirqueSceneDelegate) {
        self.wedges              = wedges
        self.rings               = rings
        self.playerOne           = playerOne
        self.playerTwo           = playerTwo
        self.cirqueSceneDelegate = cirqueSceneDelegate
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        
        board = makeBoard(sizedFor: view)
        
        if let board = board {
            addChild(board)
        }
        
        board?.populateSpaces()
    }
    
    private func makeBoard(sizedFor view: SKView) -> Board {
        
        var gameGenerator = GameGenerator(wedges: wedges, rings: rings, container: view.frame)
        let game = gameGenerator.generateGame(for: view)
        
        let radius      = game.radius
        let spaces      = game.spaces
        let wedgeRanges = game.wedgeRanges
        let ringRanges  = game.ringRanges
        
        return Board(radius, spaces: spaces, wedgeRanges: wedgeRanges, ringRanges: ringRanges, spaceDelegate: self)
    }
    
// MARK: Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchOrigin = touches.first?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchOrigin = touchOrigin, let touchCurrent = touches.first?.location(in: self) else { return }
        
        let angle    = getAngle(touchOrigin, and: touchCurrent)
        let distance = getDistance(touchOrigin, and: touchCurrent)
        
        board?.handleTouch(at: angle, and: distance)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchOrigin = nil
    }
    
// MARK: Presses
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        board?.handlePress()
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

extension CirqueScene: SpaceDelegate {
    
    /** Open a `Space` **/
    func open(_ gameSpace: Space) {
        gameSpace.open()
    }
    
    /** Highlight a `Space` **/
    func highlight(_ gameSpace: Space) {
        gameSpace.highlight()
    }
    
    /** Select a `Space` **/
    func select(_ gameSpace: Space, complete: (Bool, PlayerChip?) -> Void) {
        
        gameSpace.select(for: currentPlayerNumber) { selected in

            if selected {
                let chip = PlayerChip(texture: currentPlayerNumber.texture, wedgeNum: gameSpace.wedgeNum, ringNum: gameSpace.ringNum)
                chip.position = gameSpace.point
                chip.zPosition = 200 // TODO: Add logic to clean this arbitrary value up
                swapPlayers()
                complete(selected, chip)
            } else {
                complete(selected, nil)
            }
        }
    }
    
    /** Close all `Space`s within a wedge **/
    func close(_ gameSpaces: [Space]) {
        
        gameSpaces.forEach { $0.close() }
        
        let wedgeColor = gameSpaces.first?.wedgeColor
        
        if playerOne.owns(wedgeColor) {
            playerOne.close(wedgeColor) { playerOneLost in
                if playerOneLost { cirqueSceneDelegate.gameEnded(winner: .two) }
            }
        }
        if playerTwo.owns(wedgeColor) {
            playerTwo.close(wedgeColor) { playerTwoLost in
                if playerTwoLost { cirqueSceneDelegate.gameEnded(winner: .one) }
            }
        }
    }
    
    /** Revive a clockwise or counter-clockwise `Space` **/
    func revive(_ gameSpace: Space) {
        gameSpace.revive() { revived in
            if revived {
                
                // if revived, remove player chip with wedge/ring num
            }
        }
    }
    
    private func swapPlayers() {
        currentPlayerNumber = currentPlayerNumber == .one ? .two : .one
    }
}
