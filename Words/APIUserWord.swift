//
//  APIUserWord.swift
//  Words
//
//  Created by Sergey Ilyushin on 10/08/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

class APIUserWord: CustomStringConvertible {
    
    public var identifier: Int
    public var progress: Float
    
    init(identifier: Int, progress: Float) {
        self.identifier = identifier
        self.progress = progress
    }
    
    var description : String {
        return "Identifier - \(identifier), progress - \(progress)"
    }
}
