//
//  MeaningsManager.swift
//  Words
//
//  Created by Sergey Ilyushin on 28/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol IMeaningsManagerOutput: class {
    func onFetchMeaningsSuccess(meanings: [Meaning])
    func onFetchMeaningsFailure(message: String)
}

protocol IMeaningsManager: class {
    func fetchMeanings(count: Int)
}

class MeaningsManager: IMeaningsManager {
    var apiDataManager: IAPIDataManager!
    var localDataManager: ILocalDataManager!
    
    weak var interactor: IMeaningsManagerOutput!
    
    func fetchMeanings(count: Int) {
        guard var ids = localDataManager.fetchMeaningIds(count: count) else {
            return self.interactor.onFetchMeaningsFailure(message: "Error loading user meanign ids")
        }
        
        // Fetch from local storage
        let localMeanings = localDataManager.fetchMeanings(identifiers: ids)
        
        if let meanings = localMeanings, meanings.count == count {
            DispatchQueue.main.async {
                self.interactor.onFetchMeaningsSuccess(meanings: meanings)
            }
            return
        }
    
        
        if let meanings = localMeanings {
            print(ids)
            let fetchedIds = meanings.map({$0.identifier})
            ids = ids.filter {!fetchedIds.contains($0) }
            print(ids)
        }
        
        // Request from server
        let succesHandler = {[unowned self] (meanings: [Meaning]) in
            self.localDataManager.saveMeanings(meanings)
            
            DispatchQueue.main.async {
                if let local = localMeanings {
                    self.interactor.onFetchMeaningsSuccess(meanings: local + meanings)
                } else {
                    self.interactor.onFetchMeaningsSuccess(meanings: meanings)
                }
            }
        }
        
        let errorHandler = {[unowned self] (error: Error) in
            DispatchQueue.main.async {
                self.interactor.onFetchMeaningsFailure(message: "Error loading meanings")
            }
        }
        apiDataManager.requestMeanings(identifiers:ids, completionHandler: succesHandler, errorHandler: errorHandler)
    }
}
