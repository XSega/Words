//
//  MeaningManager.swift
//  Words
//
//  Created by Sergey Ilyushin on 20/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol MeaningManagerDataSource {
    func numberOfMeanings() -> Int
    func meaningAtIndex(_ index: Int)
}

class MeaningManager {
    
    func requestAnyMeaning(completionHandler: (Meaning) -> Void, errorHandler: (Error) -> Void) {
        
    }
}
