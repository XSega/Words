//
//  AuthAPI.swift
//  Words
//
//  Created by Sergey Ilyushin on 27/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

// MARK:- API protocol

protocol IAuthAPI: class{
    func requestToken(email: String, completionHandler: ((String) -> Void)?, errorHandler: ((Error) -> Void)?)
}

// MARK:- Skyeng API protocol implementation

class SkyengAuthAPI: IAuthAPI {
    
    fileprivate var session: Session!
    
    init(session: Session) {
        self.session = session
    }
    
    func requestToken(email: String, completionHandler: ((String) -> Void)?, errorHandler: ((Error) -> Void)?) {
        let parameters: Dictionary = [
            "email": email,
            ]
        
        session.request(url: "https://words.skyeng.ru/api/public/v1/users/token", parameters: parameters, completionHandler: { (json) in
            completionHandler?("Token was requested")
        }) { (error) in
            print(error.localizedDescription)
            errorHandler?(error)
        }
    }
}

// MARK:- Fake API protocol implementation

class FakeAuthPI {
    
    func requestToken(email: String, completionHandler: ((String) -> Void)?, errorHandler: ((Error) -> Void)?) {
        
    }
}
