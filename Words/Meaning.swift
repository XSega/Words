//
//  Meaning.swift
//  Words
//
//  Created by Sergey Ilyushin on 20/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

class Meaning: CustomStringConvertible {
    public var identifier: Int
    public var text: String
    public var translation: String
    
    public var imageData: Data?
    public var soundData: Data?
    public var alternatives: [Alternative]?
    
    init(identifier: Int, text: String, translation: String) {
        self.text = text
        self.translation = translation
        self.identifier = identifier
    }
    
    func randomTranslation() -> String {
        guard arc4random_uniform(2) == 0  else {
            return translation
        }
        if let alternatives = alternatives {
            let alternative = alternatives.randomItem()
            return alternative.translation
        }
        return translation
    }
    
    func randomTranslations() -> [String] {
        var translations = [String]()
        translations.append(translation)
        
        if let alternatives = alternatives?.shuffled() {
            if alternatives.count > 0 {
                translations.append(alternatives[0].translation)
            }
            if alternatives.count > 1 {
                translations.append(alternatives[1].translation)
            }
            if alternatives.count > 2 {
                translations.append(alternatives[2].translation)
            }
        }
        return translations.shuffled()
    }

    func randomVariants() -> [Variant] {
        var variants = [Variant]()
        variants.append(Variant(text: text, translation: translation))
        
        if let alternatives = alternatives?.shuffled() {
            if alternatives.count > 0 {
                variants.append(alternatives[0])
            }
            if alternatives.count > 1 {
                variants.append(alternatives[1])
            }
            if alternatives.count > 2 {
                variants.append(alternatives[2])
            }
        }
        return variants.shuffled()
    }

    var description : String {
        return "Identifier - \(identifier), text - \(text)"
    }
}

typealias Variant = Alternative

class Alternative {
    public var text: String
    public var translation: String
    
    init(text: String, translation: String) {
        self.text = text
        self.translation = translation
    }
    
    var description : String {
        return "text - \(text), translate - \(translation)"
    }
}

extension Meaning {
    convenience init(meaningData: MeaningData) {
        self.init(identifier: Int(meaningData.identifier), text: meaningData.text, translation: meaningData.translation)
        self.imageData = meaningData.image
        self.soundData = meaningData.sound

        if let alternativesData = meaningData.alternatives  {
            var alternatives = [Alternative]()
            
            for alternativeData in alternativesData {
                let alternative = Alternative(text: alternativeData.text, translation: alternativeData.translate)
                alternatives.append(alternative)
            }
            self.alternatives = alternatives
        }
    }
}
