//
//  UserWordsManager.swift
//  Words
//
//  Created by Sergey Ilyushin on 10/08/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol IUserWordsDictionaryManagerOutput: class {
    func onLoadUserWordsSuccess(userWords: [UserWord])
    func onLoadUserWordsFailure(message: String)
}

protocol IUserWordsDictionaryManager: class {
    func loadBeginnerUserWords()
    func loadElementaryUserWords()
    func loadPreIntermediateUserWords()
    func loadIntermediateUserWords()
}

class UserWordsDictionaryManager: IUserWordsDictionaryManager {
    var localDataManager: ILocalDataManager!
    
    weak var interactor: IUserWordsDictionaryManagerOutput!
    
    func loadBeginnerUserWords() {
        let userWords = loadJsonUserWordsDictionary("beginner")
        saveUserWords(userWords)
    }
    
    func loadElementaryUserWords() {
        let userWords = loadJsonUserWordsDictionary("elementary")
        saveUserWords(userWords)
    }
    
    func loadPreIntermediateUserWords() {
        let userWords = loadJsonUserWordsDictionary("pre-intermediate")
        saveUserWords(userWords)

    }
    
    func loadIntermediateUserWords() {
        let userWords = loadJsonUserWordsDictionary("intermediate")
        saveUserWords(userWords)
    }
    
    func saveUserWords(_ userWords: [UserWord]) {
        localDataManager.saveUserWords(userWords, completionHandler: { [unowned self] (count) in
            DispatchQueue.main.async {
                self.interactor.onLoadUserWordsSuccess(userWords: userWords)
            }
        }) { (error) in
            
        }
    }
    
    // MARK: Utils
    
    fileprivate func loadJsonUserWordsDictionary(_ path: String) -> [UserWord] {
        let filePath = Bundle.main.path (forResource: path, ofType:"json")
        let data = try! Data.init(contentsOf: URL(fileURLWithPath: filePath!))
        
        let jsonArray = try! JSONSerialization.jsonObject (with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [[String: Any]]
        
        let userWords = parseUserWords(json: jsonArray)
        return userWords
    }
    
    fileprivate func parseUserWords(json: [[String: Any]]) -> [UserWord] {
        var words = [UserWord]()
        for jsonItem in json {
            if let id = jsonItem["meaningId"] as? Int, let progress = jsonItem["progress"] as? Float {
                let progress = (1 - progress) * 10
                let word = UserWord(identifier: id, progress: Int(progress))
                words.append(word)
            }
        }
        return words
    }
}
