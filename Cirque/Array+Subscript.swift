//
//  Array+Subscript.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/6/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import Foundation

extension Array {
    
    subscript (wrapping index: Int) -> Element {
        return self[(index % count + count) % count]
    }
}
