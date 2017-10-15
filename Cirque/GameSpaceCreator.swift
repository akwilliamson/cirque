//
//  GameSpaceShaper.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/3/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import CoreGraphics
import SpriteKit

struct GameSpaceCreator {
    
// MARK: Constant
    
    public  let radius: CGFloat
    private let wedges: Int
    private let rings: Int
    private let center: CGPoint
    
    //private let ringMargin: CGFloat = 7 // Spacing between each concentric ring. Arbitrary
    private let openCenterPercentageOfRadius: CGFloat = 0.05 // % of radius devoted to the open center of game board. Arbitrary
    private let wedgeColors: [WedgeColor] = [.green, .yellow, .orange, .red, .pink, .purple, .blue, .brown]
// MARK: Variable
    
    private var startRadius: CGFloat      // % of container radius
    private var startAngle: CGFloat = 0.0 // % of circumference
    
    private var lengthForSpace: CGFloat { return .tau/wedges.cg }
    private var widthForSpace:  CGFloat { return radius/rings.cg - CGFloat(rings) }
    
    private var endAngle:  CGFloat { return (startAngle  + lengthForSpace) }
    private var endRadius: CGFloat { return startRadius - widthForSpace  }
    
    private var wedgeRange: ClosedRange<CGFloat> { return (startAngle...endAngle)   }
    private var ringRange:  ClosedRange<CGFloat> { return (endRadius...startRadius) }
    
    private var path: CGPath {
        let path = UIBezierPath(arcCenter: center, radius: startRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
                    path.addArc(withCenter: center, radius: endRadius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
        
        path.close()
        
        return path.cgPath
    }
    
    init(wedges: Int, rings: Int, container: CGRect) {
        self.wedges      = wedges
        self.rings       = rings
        self.center      = container.center
        self.radius      = container.radius(0.48)
        self.startRadius = container.radius(0.48)
    }
    
    mutating func generateGame(in view: SKView) -> (spaces: [[GameSpace]], wedgeRanges: [Int: ClosedRange<CGFloat>], ringRanges: [Int: ClosedRange<CGFloat>]) {
        
        var spaces: [[GameSpace]] = [[],[],[],[],[],[],[],[]]
        // The range of each angle within the game board devoted to each group
        var wedgeRanges = [Int: ClosedRange<CGFloat>]()
        // The range of each width within the game board devoted to each ring
        var ringRanges = [Int: ClosedRange<CGFloat>]()
        
        for wedgeNum in (1...wedges) {
            wedgeRanges[wedgeNum.index] = wedgeRange
            
            for ringNum in 1...rings {
                ringRanges[ringNum.index] = ringRanges[ringNum.index] ?? ringRange
                
                let space = createSpace(view: view, wedgeNum: wedgeNum, ringNum: ringNum)
                
                spaces[wedgeNum.index].append(space)
                
                startRadius = incrementStartRadiusFor(ringNum.cg)
            }
            startRadius = radius
            startAngle = incrementStartAngleFor(wedgeNum.cg)
        }
        
        return (spaces, wedgeRanges, ringRanges)
    }
    
    private func createSpace(view: SKView, wedgeNum: Int, ringNum: Int) -> GameSpace {
        
        let shapeNode = SKShapeNode(path: path)
        shapeNode.strokeColor = .black
        shapeNode.lineWidth = 2.5
        shapeNode.fillColor = wedgeColors[wedgeNum.index].regularColor
        
        let texture = view.texture(from: shapeNode)!
        
        let gs = GameSpace(texture: texture, wedgeNum: wedgeNum, ringNum: ringNum)

        gs.position = shapeNode.frame.center
        
        return gs
    }
    
    private func incrementStartAngleFor(_ wedgeNum: CGFloat) -> CGFloat {
        let percentageOfCircumferenceForWedge = wedgeNum/wedges.cg * .tau  // N/X % of circumference
        return percentageOfCircumferenceForWedge
    }
    
    private func incrementStartRadiusFor(_ ringNum: CGFloat) -> CGFloat {
        let percentageOfRadiusForRing = 1 - ringNum/rings.cg
        let percentageOfShrinkForRing = openCenterPercentageOfRadius * ringNum/rings.cg
        return radius * (percentageOfRadiusForRing + percentageOfShrinkForRing)
    }
}
