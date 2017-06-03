import UIKit

struct Shape {
    
    let center:    CGPoint
    let width:     CGFloat
    let length:    CGFloat
    var radiusOut: CGFloat { didSet { self.radiusIn = radiusOut - width } }
    var radiusIn:  CGFloat
    var start:     CGFloat { didSet { self.end = start + length } }
    var end:       CGFloat
    
    init(center: CGPoint, width: CGFloat, length: CGFloat, start: CGFloat = 0.0, radius: CGFloat) {
        self.center    = center
        self.width     = width
        self.length    = length
        self.start     = start
        self.radiusOut = radius
        self.radiusIn  = radius - width
        self.end       = start + length
    }
    
    var path: CGPath {
        
        let path = UIBezierPath(arcCenter: center, radius: radiusOut, startAngle: start, endAngle: end, clockwise: true)
                   path.addArc(withCenter: center, radius: radiusIn, startAngle: end, endAngle: start, clockwise: false)
        
        return path.cgPath
    }
}
