//
//  GameSpace.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/3/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import CoreGraphics
import SpriteKit

final class Space: SKSpriteNode {

    public var wedgeNum: Int = 0
    public var ringNum: Int  = 0
    public var owner: PlayerNumber?
    public var point: CGPoint = .zero
    public var wedgeColor: WedgeColor {
        return WedgeColor(rawValue: CGFloat(wedgeNum)) ?? .none
    }
    public var state: SpaceState = .open {
        didSet {
            color = colorForState()
        }
    }
    
    private var isSelectable: Bool  {
        return state != .closed && state != .selected
    }
    private var isAlive: Bool {
        return state != .closed
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(texture: SKTexture, point: CGPoint, wedgeNum: Int, ringNum: Int) {
        super.init(texture: texture, color: .clear, size: texture.size())
        self.point = point
        self.wedgeNum = wedgeNum
        self.ringNum = ringNum
        self.color = colorForState()
    }
    
    private func colorForState() -> UIColor {
        switch state {
        case .open:
            colorBlendFactor = 0.0
            return wedgeColor.regularColor
        case .highlighted:
            colorBlendFactor = 1.0
            return wedgeColor.highlightColor
        case .selected:
            colorBlendFactor = 0.0
            return wedgeColor.regularColor
        case .closed:
            colorBlendFactor = 0.0
            return wedgeColor.closedColor
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
    
    func select(for playerNumber: PlayerNumber, complete: (Bool) -> Void) {
        if isSelectable {
            self.owner = playerNumber
            select()
        }
        complete(state == .selected)
    }
    
    func revive(complete: (Bool) -> Void) {
        if isAlive {
            state = .open
        }
        complete(state == .open)
    }
    
    func close() {
        state = .closed
    }
}
