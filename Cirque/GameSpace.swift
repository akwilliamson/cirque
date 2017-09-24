//
//  GameSpace.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/3/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import CoreGraphics
import SpriteKit

class GameSpace: SKShapeNode {
    
    var groupNum: Int = 0
    var ringNum: Int  = 0
    var owner: Player? {
        didSet { if let owner = owner { select(with: owner.color) } else { reopen() } }
    }
    
    var state: GameSpaceState = .open {
        didSet {
            fillColor = spaceColorForState()
        }
    }
    var isSelectable: Bool  {
        return state != .selected && state != .closed
    }
    var isAlive: Bool {
        return state != .closed
    }
    
    var groupColor: GroupColor {
        return GroupColor(rawValue: CGFloat(groupNum)) ?? .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(path: CGPath) {
        super.init()
        self.path = path
        self.isUserInteractionEnabled = true
    }
    
    convenience init(path: CGPath, groupNum: Int, ringNum: Int) {
        self.init(path: path)
        self.groupNum = groupNum
        self.ringNum = ringNum
        self.fillColor = spaceColorForState()
    }
    
    func spaceColorForState() -> UIColor {
        switch state {
        case .open:        return groupColor.regularColor
        case .highlighted: return groupColor.highlightColor
        case .selected:    return groupColor.regularColor
        case .closed:      return groupColor.closedColor
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
        node.size = CGSize(width: 30, height: 30)
        node.position = CGPoint(x: frame.center.x, y: frame.center.y)
        
        addChild(node)
    }
    
    func removeOwner() {
        children.forEach { $0.removeFromParent() }
    }
}
