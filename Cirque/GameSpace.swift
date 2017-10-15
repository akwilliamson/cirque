//
//  GameSpace.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/3/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import CoreGraphics
import SpriteKit

class GameSpace: SKSpriteNode {

    var wedgeNum: Int = 0
    var ringNum: Int  = 0
    var owner: Player? {
        didSet { if let owner = owner { select(with: owner.color) } else { reopen() } }
    }
    
    var state: SpaceState = .open {
        didSet {
            color = spaceColorForState()
        }
    }
    var isSelectable: Bool  {
        return state != .closed && state != .selected
    }
    var isAlive: Bool {
        return state != .closed
    }
    
    var wedgeColor: WedgeColor {
        return WedgeColor(rawValue: CGFloat(wedgeNum)) ?? .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(texture: SKTexture, wedgeNum: Int, ringNum: Int) {
        super.init(texture: texture, color: .clear, size: texture.size())
        self.wedgeNum = wedgeNum
        self.ringNum = ringNum
        self.color = spaceColorForState()
    }
    
    func spaceColorForState() -> UIColor {
        switch state {
        case .open:        return wedgeColor.regularColor
        case .highlighted: return wedgeColor.highlightColor
        case .selected:    return wedgeColor.regularColor
        case .closed:      return wedgeColor.closedColor
        }
    }
    
    func open() {
        if isSelectable {
            state = .open
        }
    }
    
    func highlight() {
        if isSelectable {
            state = .highlighted
        }
    }
    
    func select(with ownerColor: UIColor) {
        if isSelectable {
            state = .selected
            addOwner(ownerColor)
        }
    }
    
    func reopen() {
        if isAlive {
            state = .open
            removeOwner()
        }
    }
    
    func close() {
        if isAlive {
            state = .closed
        }
    }
    
    func set(owner: Player?, complete: (Bool) -> Void) {
        self.owner = owner
        complete(state == .selected)
    }
    
    func addOwner(_ selectionColor: UIColor) {
        let name = selectionColor == .white ? "white" : "black"
        let node = SKSpriteNode(imageNamed: name)
        node.size = CGSize(width: 50, height: 50)
        node.position = frame.center
        addChild(node)
    }
    
    func removeOwner() {
        children.forEach { $0.removeFromParent() }
    }
}
