//
//  LoginDictionaryInteractor.swift
//  Words
//
//  Created by Sergey Ilyushin on 27/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol ILoginDictionaryInteractor: class {
    func selectBeginnerLevel()
    func selectElementaryLevel()
    func selectPreIntermediateLevel()
    func selectIntermediateLevel()
}

protocol ILoginDictionaryDataStore
{

}

class LoginDictionaryInteractor: ILoginDictionaryInteractor, ILoginDictionaryDataStore {
    var manager: IUserWordsDictionaryManager!
    weak var view: ILoginDictionaryView!

    // MARK: ILoginDictionaryInteractor protocol
    
    func selectBeginnerLevel() {
        saveDictionary("Beginner")
        manager.loadBeginnerUserWords()
        view.displayLoadingProgress()
    }
    
    func selectElementaryLevel() {
        saveDictionary("Elementary")
        manager.loadElementaryUserWords()
        view.displayLoadingProgress()
    }
    
    func selectPreIntermediateLevel() {
        saveDictionary("PreIntermediate")
        manager.loadPreIntermediateUserWords()
        view.displayLoadingProgress()
    }
    
    func selectIntermediateLevel() {
        saveDictionary("Intermediate")
        manager.loadIntermediateUserWords()
        view.displayLoadingProgress()
    }
    
    
    func presentSuccessful() {
        view.hideLoadingProgress()
        view.displaySuccessful(text: "OK")
    }
    
    func presentError(text: String) {
        view.hideLoadingProgress()
        view.displayError(text: text)
    }
    
    func saveDictionary(_ level: String) {
        UserDefaults.standard.set(level, forKey: Keys.User.Dictionary)
    }
    
    func removeDictionary() {
        UserDefaults.standard.removeObject(forKey: Keys.User.Dictionary)
    }
}

extension LoginDictionaryInteractor: IUserWordsDictionaryManagerOutput {
    func onLoadUserWordsSuccess(userWords: [UserWord]) {
        presentSuccessful()
    }
    
    func onLoadUserWordsFailure(message: String) {
        presentError(text: message)
    }
}
