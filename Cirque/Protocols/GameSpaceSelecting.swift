//
//  GameSpaceSelecting.swift
//  Cirque
//
//  Created by Aaron Williamson on 7/13/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

protocol GameSpaceSelecting {
    
    func select(_ gameSpace: GameSpace?, complete: (Bool) -> Void)
    func close(_ gameSpaces: [GameSpace])
}
