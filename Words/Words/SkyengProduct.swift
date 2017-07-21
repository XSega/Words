//
//  SkyengProduct.swift
//  Words
//
//  Created by Sergey Ilyushin on 20/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol ISkyengProduct {
    func requestMeanings(email: String, token: String)
    func requestMeaning(identifier: String)
    func requestToken(email: String)
    
}

class SkyengProduct: ISkyengProduct {
    
    fileprivate var session: Session!
    
    init(session: Session) {
        self.session = session
    }
    
    func requestMeanings(email: String, token: String) {
        let parameters: Dictionary = [
            "email":email,
            "token":token
        ]
        
        session.request(url: "https://words.skyeng.ru/api/public/v1/users/meanings", parameters: parameters, completionHandler: { (json) in
            if let jsonArray = json as? [[String: Any]] {
                for meaningJson in jsonArray {
                    let id = meaningJson["meaningId"] as! Int
                    let progress = meaningJson["progress"]
                    
                    print("meaningId \(id)")
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func requestMeaning(identifier: String) {
        let parameters: Dictionary = [
            "ids": identifier,
        ]
        
        session.request(url: "https://dictionary.skyeng.ru/api/public/v1/meanings", parameters: parameters, completionHandler: { (json) in
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func requestToken(email: String) {
        let parameters: Dictionary = [
            "email": email,
        ]
        
        session.request(url: "https://words.skyeng.ru/api/public/v1/users/token", parameters: parameters, completionHandler: { (json) in
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

class TestSkyengProduct {
    
}
