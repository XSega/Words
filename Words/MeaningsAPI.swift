//
//  SkyengProduct.swift
//  Words
//
//  Created by Sergey Ilyushin on 20/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

// MARK:- API protocol

protocol IAPI: class{
    func requestMeanings(identifiers: [Int], completionHandler: @escaping([APIMeaning]) -> Void, errorHandler: @escaping(Error) -> Void)
}

// MARK:- Skyeng API protocol implementation

class SkyengAPI: IAPI {
    fileprivate var session: Session!
    
    init(session: Session) {
        self.session = session
    }
    
    func requestMeanings(identifiers: [Int], completionHandler: @escaping([APIMeaning]) -> Void, errorHandler: @escaping(Error) -> Void) {
        let stringArray = identifiers.flatMap { String($0) }
        let string = stringArray.joined(separator: ",")
        let parameters: Dictionary = [
            "ids": string
        ]
        
        session.request(url: "https://dictionary.skyeng.ru/api/public/v1/meanings", parameters: parameters, completionHandler: { (json) in
            if let jsonArray = json as? [[String: Any]] {
                let meanings = SkyengParser.parseMeanings(jsonArray: jsonArray)
                completionHandler(meanings)
            }
        }) { (error) in
            print(error.localizedDescription)
            errorHandler(error)
        }
    }
}

// MARK:- Fake API protocol implementation

class FakeAPI {
    func requestMeanings(identifiers: [Int], completionHandler: @escaping(APIMeaning) -> Void, errorHandler: @escaping(Error) -> Void) {
        let filePath = Bundle.main.path (forResource: "Meaning192984", ofType:"json")
        let data = try! Data.init(contentsOf: URL(fileURLWithPath: filePath!))
        
        let jsonArray = try! JSONSerialization.jsonObject (with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [[String: Any]]

        let meaning = SkyengParser.parseMeaning(jsonObject: jsonArray[0]) //Meaning()
        completionHandler(meaning)
    }
}

// MARK:- SkyengParser class

class SkyengParser {
    
    class func parseMeanings(jsonArray: [[String: Any]]) -> [APIMeaning] {
        var meanings = [APIMeaning]()
        for jsonObject in jsonArray {
            let meaning = SkyengParser.parseMeaning(jsonObject: jsonObject)
            meanings.append(meaning)
        }
        return meanings
    }
    
    class func parseMeaning(jsonObject: [String: Any]) -> APIMeaning {
        let meaning = APIMeaning()
        if let id = jsonObject["id"] as? String {
            meaning.identifier = Int(id)
        }
        meaning.text = jsonObject["text"]  as? String
        
        if let soundUrl = jsonObject["soundUrl"] as? String {
            meaning.soundUrl = "http:" + soundUrl
        }
        if let jsonTranslation = jsonObject["translation"] as? [String: Any] {
            meaning.translation = jsonTranslation["text"] as? String
        }
        if let jsonImages = jsonObject["images"] as? [[String: String]], jsonImages.count > 0 {
            meaning.imageUrl = "http:" + jsonImages[0]["url"]!
        }
        
        // Parse alternative translations
        if let jsonAlternatives = jsonObject["alternativeTranslations"] as? [[String: Any]] {
            var alternatives = [APIAlternative]()
            for jsonAlternative in jsonAlternatives {
                let alternative = APIAlternative()
                alternative.text = jsonAlternative["text"] as? String
                
                if let jsonTranslation = jsonAlternative["translation"] as? [String: Any] {
                    alternative.translation = jsonTranslation["text"] as? String
                }
                alternatives.append(alternative)
            }
            meaning.alternatives = alternatives
        }
        
        return meaning
    }
}
