//
//  Collection+Extension.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/15/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import Foundation

extension Collection where Index == Int {
    
 // Picks and returns a random element of the collection.
    var randomElement: Iterator.Element? {
        return isEmpty ? nil : self[Int(arc4random_uniform(UInt32(endIndex)))]
    }
}
