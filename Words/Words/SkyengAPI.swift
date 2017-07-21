//
//  SkyengAPI.swift
//  Words
//
//  Created by Sergey Ilyushin on 20/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation
import Alamofire

//https://words.skyeng.ru/api/public/v1/users/meanings?email=%22sergey.ilyushin88@gmail.com%22&token=%22fd1ab%22

class SkyengAPI {
    
    public var email: String?
    public var token: String?
    
    fileprivate var product: ISkyengProduct!
    
    init(product: ISkyengProduct) {
        self.product = product
    }
    
    func requestMeanings() {
        guard let email = email, let token = token else {
            print("Email or token error")
            return
        }
        product.requestMeanings(email: email, token: token)
    }
    
    func requestMeaning(identifier: String) {
        product.requestMeaning(identifier: identifier)
    }
}
