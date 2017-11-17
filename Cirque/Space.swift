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
        case .open: colorBlendFactor = 0.0
            return wedgeColor.regularColor
        case .highlighted: colorBlendFactor = 1.0
            return wedgeColor.highlightColor
        case .selected: colorBlendFactor = 0.0
            return wedgeColor.regularColor
        case .closed: colorBlendFactor = 0.0
            return wedgeColor.closedColor
        }
    }
    
    func open() {
        if isSelectable {
            owner = nil
            state = .open
        }
    }
    
    func highlight() {
        if isSelectable {
            state = .highlighted
        }
    }
    
    func select(for player: PlayerNumber, complete: (Bool) -> Void) {
        if isSelectable {
            owner = player
            addChip()
            state = .selected
        }
        complete(state == .selected)
    }
    
    private func addChip() {
        let chip = PlayerChip(texture: owner?.texture)
        chip.position = point
        chip.zPosition = 200
        addChild(chip)
    }
    
    func revive() {
        if isAlive {
            owner = nil
            state = .open
        }
    }
    
    func close() {
        if isAlive {
            state = .closed
        }
    }
}
