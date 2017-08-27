//
//  MeaningsInteractor.swift
//  Words
//
//  Created by Sergey Ilyushin on 26/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol ITrainingInteractorOutput: class {
    func onFetchMeaningsSuccess(meanings: [Meaning])
    func onFetchMeaningsFailure(message: String)
}

protocol ITrainingInteractor: class {
    func fetchMeanings()
}

class TrainingInteractor: ITrainingInteractor {
    var meaningIds = [Int]()
    var apiDataManager: IAPIDataManager!
    var localDataManager: ILocalDataManager!
    
    weak var presenter: ITrainingInteractorOutput!
    
    func fetchMeanings() {
        let ids = meaningIds.randomItems(count: 10)
        
        // Fetch from local storage
        //let meanings = localDataManager.fetchMeanings(identifiers: ids)// {
            //presenter.onFetchProductsSuccess(meanings: meanings)
           // return
        //}
    
        
        // Request from server
        let succesHandler = {[unowned self] (meanings: [Meaning]) in
            DispatchQueue.main.async {
                self.presenter.onFetchMeaningsSuccess(meanings: meanings)
            }
        }
        
        let errorHandler = {[unowned self] (error: Error) in
            DispatchQueue.main.async {
                self.presenter.onFetchMeaningsFailure(message: "Error loading")
            }
        }
        apiDataManager.requestMeanings(identifiers: ids, completionHandler: succesHandler, errorHandler: errorHandler)
    }
}

