//
//  LoginTokeInteractor.swift
//  Words
//
//  Created by Sergey Ilyushin on 27/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol ILoginTokenInteractor: class {
    func login(token: String?)
    func sendToken()
}

protocol ILoginTokenDataStore
{
    var email: String! { get set }
}

class LoginTokenInteractor: ILoginTokenInteractor, ILoginTokenDataStore {
    weak var view: ILoginTokenView!
    
    var manager: IUserWordsManager!
    var api: IAuthAPI!
    
    var email: String!
    
    // MARK: ILoginTokenInteractor protocol
    
    func login(token: String?) {
        guard let token = token else {
            presentError(text: "Enter token")
            return
        }
        updateUserWords(token: token)
    }
    
    func sendToken() {
        let completionHandler = { [unowned self] (token: String) in
            self.view.hideLoadingProgress()
        }
        
        let errorHandler = { [unowned self] (error: Error) in
            self.view.hideLoadingProgress()
        }
        
        view.displayLoadingProgress()
        api.requestToken(email: email, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    // Private methods
    
    fileprivate func updateUserWords(token: String) {
        print("email - \(email), token - \(String(describing: token))")
        view.displayLoadingProgress()
        manager.updateUserWords(email: email, token: token)
    }
    
    fileprivate func presentSuccessful() {
        view.displaySuccessful(text: "OK")
    }
    
    fileprivate  func presentError(text: String) {
        view.displayError(text: text)
    }

    fileprivate func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: Keys.User.Token)
    }
    
    fileprivate func removeToken() {
        UserDefaults.standard.removeObject(forKey: Keys.User.Token)
    }
}

extension LoginTokenInteractor: IUserWordsManagerOutput {
    func onUpdateUserWordsSuccess(token: String, userWords: [UserWord]) {
        saveToken(token)
        presentSuccessful()
        view.hideLoadingProgress()
    }
    
    func onUpdateUserWordsFailure(token: String, message: String) {
        removeToken()
        presentError(text: "Token is incorrect")
        view.hideLoadingProgress()
    }
}
