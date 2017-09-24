//
//  GroupColor.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/23/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit

enum GroupColor: CGFloat {

    case none
    case blue
    case green
    case yellow
    case orange
    case brown
    case red
    case pink
    case purple
    
    var regularColor: UIColor {
        switch self {
        case .none:   return .gray
        case .blue:   return UIColor(hue: 0.62, saturation: 0.95, brightness: 1.00, alpha: 1.0)
        case .green:  return UIColor(hue: 0.28, saturation: 0.82, brightness: 0.55, alpha: 1.0)
        case .yellow: return UIColor(hue: 0.16, saturation: 1.00, brightness: 0.77, alpha: 1.0)
        case .orange: return UIColor(hue: 0.08, saturation: 1.00, brightness: 1.00, alpha: 1.0)
        case .brown:  return UIColor(hue: 0.10, saturation: 0.72, brightness: 0.45, alpha: 1.0)
        case .red:    return UIColor(hue: 0.03, saturation: 0.85, brightness: 0.82, alpha: 1.0)
        case .pink:   return UIColor(hue: 0.94, saturation: 0.85, brightness: 1.00, alpha: 1.0)
        case .purple: return UIColor(hue: 0.82, saturation: 0.68, brightness: 0.57, alpha: 1.0)
        }
    }
    
    var highlightColor: UIColor {
        return .lightGray
    }
    
    var closedColor: UIColor {
        return .gray
    }
}
