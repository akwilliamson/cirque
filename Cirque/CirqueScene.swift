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
    var gameManager: GameManager
    var sceneDelegate: SceneDelegate
    
    private var touchOrigin: CGPoint?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(_ size: CGSize, wedges: Int, rings: Int, sceneDelegate: SceneDelegate) {
        self.board = makeBoard(sizedFor: view!, wedges: wedges, rings: rings)
        
        self.gameManager = GameManager(board: <#T##Board#>, playerOne: <#T##Player#>, playerTwo: <#T##Player#>, currentPlayer: <#T##PlayerNumber#>)
        self.sceneDelegate = sceneDelegate
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        addChild(board)
        board.populateSpaces() // TODO: Animate
    }
    
    private func makeBoard(sizedFor view: SKView, wedges: Int, rings: Int) -> Board {
        
        var boardGenerator = GameGenerator(wedges: wedges, rings: rings, container: view.frame)
        let board = boardGenerator.generateBoard(for: view)
        
        return Board(board.radius, spaces: board.spaces, wedgeRanges: board.wedgeRanges, ringRanges: board.ringRanges)
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

extension CirqueScene: SpaceDelegate {
    
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
    
    func swapPlayers() {
        currentPlayerNumber = currentPlayerNumber == .one ? .two : .one
    }
}
