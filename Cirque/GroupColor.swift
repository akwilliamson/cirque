//
//  GroupColor.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/23/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit

enum GroupColor: CGFloat {

    case gold
    case lime
    case forest
    case cyan
    case ocean
    case royal
    case magenta
    case fire
    case none
    
    var openColor: UIColor {
        return UIColor(hue: rawValue/8.0, saturation: 0.5, brightness: 1.0, alpha: 1.0)
    }
    
    var highlightColor: UIColor {
        return UIColor(hue: rawValue/8.0, saturation: 0.8, brightness: 1.0, alpha: 1.0)
    }
    
    var selectedColor: UIColor {
        return UIColor(hue: rawValue/8.0, saturation: 0.8, brightness: 1.0, alpha: 1.0)
    }
    
    var closedColor: UIColor {
        return .gray
    }
}
