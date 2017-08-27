//
//  SkyengMeaning.swift
//  Words
//
//  Created by Sergey Ilyushin on 22/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

class APIMeaning {
    public var identifier: Int?
    public var imageUrl: String?
    public var soundUrl: String?
    public var text: String?
    public var translation: String?
    public var alternatives: [APIAlternative]?
    
    var description : String {
        return "Identifier - \(identifier), text - \(text)"
    }
}

class APIAlternative {
    public var text: String?
    public var translation: String?
    
    var description : String {
        return "text - \(text), translation - \(translation)"
    }
    
}
