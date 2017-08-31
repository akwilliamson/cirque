//
//  GroupColor.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/23/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit

enum GroupColor {

    case gold
    case lime
    case forest
    case cyan
    case ocean
    case royal
    case magenta
    case fire
    
    var color: UIColor {
        switch self {
        case .gold:
            return UIColor(hue: 1.0/8.0, saturation: 0.5, brightness: 1.0, alpha: 1.0)
        case .lime:
            return UIColor(hue: 2.0/8.0, saturation: 0.5, brightness: 1.0, alpha: 1.0)
        case .forest:
            return UIColor(hue: 3.0/8.0, saturation: 0.5, brightness: 1.0, alpha: 1.0)
        case .cyan:
            return UIColor(hue: 4.0/8.0, saturation: 0.5, brightness: 1.0, alpha: 1.0)
        case .ocean:
            return UIColor(hue: 5.0/8.0, saturation: 0.5, brightness: 1.0, alpha: 1.0)
        case .royal:
            return UIColor(hue: 6.0/8.0, saturation: 0.5, brightness: 1.0, alpha: 1.0)
        case .magenta:
            return UIColor(hue: 7.0/8.0, saturation: 0.5, brightness: 1.0, alpha: 1.0)
        case .fire:
            return UIColor(hue: 8.0/8.0, saturation: 0.5, brightness: 1.0, alpha: 1.0)
        }
    }
}
