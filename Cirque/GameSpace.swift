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
        didSet {
            if let owner = owner {
                select()
                addOwner(owner.selectionColor)
            } else {
                reopen()
            }
        }
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
        case .open:        return groupColor.openColor
        case .highlighted: return groupColor.highlightColor
        case .selected:    return groupColor.highlightColor
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
    
    func select() {
        if isSelectable {
            state = .selected
        }
    }
    
    func close() {
        if isAlive {
            state = .closed
        }
    }
    
    func reopen() {
        if isAlive {
            state = .open
            children.forEach { $0.removeFromParent() }
        }
    }
    
    func set(owner: Player, complete: (Bool) -> Void) {
        if isSelectable {
            self.owner = owner
            complete(true)
        } else {
            complete(false)
        }
    }
    
    func addOwner(_ selectionColor: UIColor) {
        let origin = CGPoint(x: frame.center.x - 15, y: frame.center.y - 15)
        let rect = CGRect(origin: origin, size: CGSize(width: 30, height: 30))
        let path = UIBezierPath(ovalIn: rect).cgPath
        let node = SKShapeNode(path: path)
        node.fillColor = selectionColor
        addChild(node)
    }
}
