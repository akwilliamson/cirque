//
//  Dictionary+Filter.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/18/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import Foundation

extension Dictionary where Value: Equatable {
    
    func keys(forValue val: Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}
