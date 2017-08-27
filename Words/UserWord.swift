//
//  UserWord.swift
//  Words
//
//  Created by Sergey Ilyushin on 09/08/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

class UserWord: CustomStringConvertible {
    
    public var identifier: Int
    public var progress: Int
    
    init(identifier: Int, progress: Int) {
        self.identifier = identifier
        self.progress = progress
    }
    
    var description : String {
        return "Identifier - \(identifier), progress - \(progress)"
    }
}

extension UserWord {
    convenience init(_ userWord: UserWordData) {
        self.init(identifier: Int(userWord.identifier), progress: Int(userWord.progress))
    }
}
