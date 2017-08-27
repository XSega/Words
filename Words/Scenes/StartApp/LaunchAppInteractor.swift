//
//  LaunchAppInteractor
//  Words
//
//  Created by Sergey Ilyushin on 27/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol ILaunchAppInteractor: class {
    func login()
}

class LaunchAppInteractor: ILaunchAppInteractor {
    var manager: IUserWordsManager!
    
    weak var view: ILaunchAppView!
    var router: ILaunchAppRouter!
    
    // MARK: ILaunchAppInteractor protocol
    
    func login() {
        let email = UserDefaults.standard.string(forKey: Keys.User.Email)
        let token = UserDefaults.standard.string(forKey: Keys.User.Token)
        
        if let email = email, let token = token {
            view.displayLoadingProgress()
            manager.updateUserWords(email: email, token: token)
        }
    }
    
    func resign() {
        removeCredential()
        router.routeToLogin()
    }
    
    func presentSuccessful() {
        view.displaySuccessful(text: "OK")
    }
    
    func presentError(text: String) {
        view.displayError(text: text)
    }
    
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: Keys.User.Token)
    }
    
    func removeCredential() {
        UserDefaults.standard.removeObject(forKey: Keys.User.Token)
    }
}

extension LaunchAppInteractor: IUserWordsManagerOutput {
    func onUpdateUserWordsSuccess(token: String, userWords: [UserWord]) {
        presentSuccessful()
        view.hideLoadingProgress()
    }
    
    func onUpdateUserWordsFailure(token: String, message: String) {
        presentError(text: message)
        view.hideLoadingProgress()
    }
}
