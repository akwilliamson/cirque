import UIKit

enum Color: Int {
    
    case blue, red, yellow, green, orange, magenta, brown, cyan
    
    var color: UIColor {

        switch self {
        case .blue:    return UIColor.blue
        case .red:     return UIColor.red
        case .yellow:  return UIColor.yellow
        case .green:   return UIColor.green
        case .orange:  return UIColor.orange
        case .magenta: return UIColor.magenta
        case .brown:   return UIColor.brown
        case .cyan:    return UIColor.cyan
        }
    }
}
