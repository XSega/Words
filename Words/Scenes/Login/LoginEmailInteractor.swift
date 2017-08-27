//
//  LoginEmailInteractor.swift
//  Words
//
//  Created by Sergey Ilyushin on 27/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol ILoginEmailInteractor: class {
    func next(email: String?)
}

protocol ILoginEmailDataStore
{
    var email: String! { get set }
}

class LoginEmailInteractor: ILoginEmailInteractor, ILoginEmailDataStore {
    
    weak var view: ILoginEmailView!
    var email: String!
    
    // MARK: ILoginEmailInteractor protocol
    
    func next(email: String?) {
        
        guard let email = email, isValidEmail(testStr: email) else {
            view.displayError(text: "Email is incorrect")
            return
        }
        
        self.email = email
        saveEmail(email)
        
        self.view.displaySuccessful(text: "Token request was sended")
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func saveEmail(_ email: String) {
        UserDefaults.standard.set(email, forKey: Keys.User.Email)
    }
    
    func removeEmail() {
        UserDefaults.standard.removeObject(forKey: Keys.User.Email)
    }
}
