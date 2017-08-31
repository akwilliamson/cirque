//
//  Collection+Extension.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/15/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import Foundation

extension Array {
    
 // Removes and returns a random element of the collection.
    mutating func randomElement() -> Iterator.Element? {
        if isEmpty {
            return nil
        } else {
            let randomIndex = Int(arc4random_uniform(UInt32(endIndex)))
            return remove(at: randomIndex)
        }
    }
}
