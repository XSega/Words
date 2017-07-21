//
//  Session.swift
//  Words
//
//  Created by Sergey Ilyushin on 20/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation
import Alamofire

protocol Session {
    func request(url: String, parameters: Dictionary<String, Any>, completionHandler:  @escaping(Any) -> Void, errorHandler: @escaping(Error) -> Void)
}

class AlamofireSession: Session {
    func request(url: String, parameters: Dictionary<String, Any>, completionHandler: @escaping(Any) -> Void, errorHandler: @escaping(Error) -> Void) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let value = response.result.value {
                completionHandler(value)
            } else if let error = response.error {
                errorHandler(error)
            }
        }
    }
}

class TestSession: Session {
    func request(url: String, parameters: Dictionary<String, Any>, completionHandler: @escaping(Any) -> Void, errorHandler: @escaping(Error) -> Void) {
        
        let filePath = Bundle.main.path (forResource: "MeaningIds", ofType:"json")
        let data = try! Data.init(contentsOf: URL(fileURLWithPath: filePath!))
        
        let json = try! JSONSerialization.jsonObject (with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
        completionHandler(json)
    }
}

