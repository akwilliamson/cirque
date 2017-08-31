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
    var ringNum: Int = 0
    
    var owner: GamePlayer? {
        didSet {
            select()
            addOwnerChip()
        }
    }
    
    var state: GameSpaceState = .open {
        didSet {
            fillColor = stateColor
        }
    }
    
    var isSelectable: Bool {
        return state != .selected && state != .closed
    }
    
    var stateColor: UIColor {
        switch state {
        case .open:
            return UIColor(hue: CGFloat(groupNum)/8.0, saturation: 0.5, brightness: 1.0, alpha: 1.0)
        case .highlighted, .selected:
            return UIColor(hue: CGFloat(groupNum)/8.0, saturation: 0.8, brightness: 1.0, alpha: 1.0)
        case .closed:
            return UIColor.gray
        }
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
        self.fillColor = stateColor
    }
    
    func highlight() {
        if isSelectable { state = .highlighted }
    }
    
    func select() {
        state = .selected
    }
    
    func reopen() {
        if isSelectable { state = .open }
    }
    
    func clearOwner() {
        children.forEach { $0.removeFromParent() }
        state = .open
    }
    
    func close() {
        let groupColor = UIColor(hue: CGFloat(groupNum)/8.0, saturation: 0.5, brightness: 1.0, alpha: 1.0)
        owner?.closeGroupColor(groupColor)
        state = .closed
    }
    
    func addOwnerChip() {
        guard let owner = owner else { return }
        let origin = CGPoint(x: frame.center.x - 15, y: frame.center.y - 15)
        let rect = CGRect(origin: origin, size: CGSize(width: 30, height: 30))
        let path = UIBezierPath(ovalIn: rect).cgPath
        let node = SKShapeNode(path: path)
        node.fillColor = owner.player.selectionColor
        addChild(node)
    }
}
