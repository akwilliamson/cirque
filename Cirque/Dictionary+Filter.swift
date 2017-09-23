//
//  Dictionary+Filter.swift
//  Cirque
//
//  Created by Aaron Williamson on 6/18/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import Foundation

extension Dictionary where Value: Equatable {
    
    func keys(for value: Value) -> [Key] {
        return self.filter { $0.1 == value }.map { $0.0 }
    }
}
