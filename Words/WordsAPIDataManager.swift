//
//  WordsAPIDataManager.swift
//  Words
//
//  Created by Sergey Ilyushin on 10/08/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol IWordsAPIDataManager: class {
    func requestUserWords(email: String, token: String, completionHandler: (([UserWord]) -> Void)?, errorHandler: ((Error) -> Void)?)
}

class WordsAPIDataManager: IWordsAPIDataManager {
    
    // MARK:- Public vars
    var api: IWordsAPI!
    
    init(api: IWordsAPI) {
        self.api = api
    }
    
    func requestUserWords(email: String, token: String, completionHandler: (([UserWord]) -> Void)?, errorHandler: ((Error) -> Void)?) {
        let succesHandler = {[unowned self](apiWords: [APIUserWord]) in
            let words = self.userWordFromAPI(apiWords: apiWords)
            completionHandler?(words)
        }
        
        let wrongHandler = {(error: Error) in
            print(error.localizedDescription)
            errorHandler?(error)
        }
        api.requestUserWords(email: email, token: token, completionHandler: succesHandler, errorHandler: wrongHandler)
    }
    
    // MARK:- Load meaning from Skyeng user words
    fileprivate func userWordFromAPI(apiWords: [APIUserWord]) -> [UserWord] {
        var words = [UserWord]()
        for apiWord in apiWords {
            let progress = (1 - apiWord.progress) * 10
            let word = UserWord(identifier: apiWord.identifier, progress: Int(progress))
            words.append(word)
        }
        return words
    }
}
