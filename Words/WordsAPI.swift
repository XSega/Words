//
//  WordsAPI.swift
//  Words
//
//  Created by Sergey Ilyushin on 30/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

// MARK: API protocol

protocol IWordsAPI: class{
    func requestUserWords(email: String?, token: String?, completionHandler: @escaping([APIUserWord]) -> Void, errorHandler: @escaping(Error) -> Void)
    func requestUserWords(completionHandler: @escaping([APIUserWord]) -> Void, errorHandler: @escaping(Error) -> Void)
}

// MARK: Skyeng API protocol implementation

class SkyengWordsAPI: IWordsAPI {
    
    // MARK: Private Vars
    
    fileprivate var session: Session!
    
    init(session: Session) {
        self.session = session
    }
    
    func requestUserWords(email: String?, token: String?, completionHandler: @escaping([APIUserWord]) -> Void, errorHandler: @escaping(Error) -> Void) {
        var parameters = Dictionary<String, Any>()
       
        if let email = email, let token = token {
            parameters["email"] = email
            parameters["token"] = token
        }
        
        // Request words
        let succesHandler = {(json: Any) in
            if let jsonArray = json as? [[String: Any]] {
                let words = WordsAPIParser.parseUserWords(json: jsonArray)
                completionHandler(words)
            } else if let jsonError = json as? [String: Any] {
                let error = WordsAPIParser.parseError(json: jsonError)
                errorHandler(error)
            }
        }
        
        let wrongHandler = {(error: Error) in
            print(error.localizedDescription)
            errorHandler(error)
        }
        session.request(url: "https://words.skyeng.ru/api/public/v1/users/meanings", parameters: parameters , completionHandler: succesHandler, errorHandler:  wrongHandler)
    }
    
    func requestUserWords(completionHandler: @escaping([APIUserWord]) -> Void, errorHandler: @escaping(Error) -> Void) {
        requestUserWords(email: nil, token: nil, completionHandler: completionHandler, errorHandler: errorHandler)
    }
}

// MARK: Fake API protocol implementation

class FakeWordsAPI {
    
    func requestUserWords(completionHandler: @escaping([Int]) -> Void, errorHandler: @escaping(Error) -> Void) {
        
    }
}

// MARK: WordsAPIParser

class WordsAPIParser {
    
    class func parseUserWords(json: [[String: Any]]) -> [APIUserWord] {
        var words = [APIUserWord]()
        for jsonItem in json {
            if let id = jsonItem["meaningId"] as? Int, let progress = jsonItem["progress"] as? Float {
                let word = APIUserWord(identifier: id, progress: progress)
                words.append(word)
            }
        }
        return words
    }
    
    class func parseError(json: [String: Any]) -> WordsAPIError {
        return WordsAPIError(json: json)
    }
}

class WordsAPIError: Error {
    var localizedDescription: String
    
    init(json: [String: Any]) {
        let jsonErrors = json["errors"] as! [[String: Any]]
        let jsonError = jsonErrors[0]
        self.localizedDescription = jsonError["message"] as! String
    }
}


//https://words.skyeng.ru/api/public/v1/users/meanings?email=sergey.ilyushin88@gmail.com&token=fd1ab
