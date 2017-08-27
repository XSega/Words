//
//  UserWordsManager.swift
//  Words
//
//  Created by Sergey Ilyushin on 10/08/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol IUserWordsManagerOutput: class {
    func onUpdateUserWordsSuccess(token: String, userWords: [UserWord])
    func onUpdateUserWordsFailure(token: String, message: String)
}

protocol IUserWordsManager: class {
    func updateUserWords(email: String, token: String)
}

class UserWordsManager: IUserWordsManager {
    var localDataManager: ILocalDataManager!
    var apiDataManager: IWordsAPIDataManager!
    
    weak var interactor: IUserWordsManagerOutput!
    
    func updateUserWords(email: String, token: String) {
        // Request from server
        let succesHandler = {[unowned self] (words: [UserWord]) in
            self.localDataManager.saveUserWords(words, completionHandler: { [unowned self] (count) in
                DispatchQueue.main.async {
                    self.interactor.onUpdateUserWordsSuccess(token: token, userWords: words)
                }
            }, errorHandler: { (error) in
                
            })
        }
        
        let wrongHandler = {[unowned self] (error: Error) in
            DispatchQueue.main.async {
                self.interactor.onUpdateUserWordsFailure(token:token, message: "Error loading meanings")
            }
        }
        apiDataManager.requestUserWords(email: email, token: token, completionHandler: succesHandler, errorHandler: wrongHandler)
    }
}
