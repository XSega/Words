//
//  StartTrainingInteractor.swift
//  Words
//
//  Created by Sergey Ilyushin on 30/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IStartTrainingInteractor {
    func fetchMeanings()
}

protocol IStartTrainingDataStore {
    var meanings: [Meaning]? { get set }
}

class StartTrainingInteractor: IStartTrainingInteractor, IStartTrainingDataStore {
    var presenter: StartTrainingPresenter!
    var manager: IMeaningsManager!
  
    var meanings: [Meaning]?
    
    func fetchMeanings() {
        manager.fetchMeanings(count: 20)
    }
    
    func presentMeanings(_ meanings: [Meaning]) {
        presenter.present(meanings: meanings)
    }
}

// MARK:- EngRuTrainingInteractor

extension StartTrainingInteractor: IMeaningsManagerOutput {
    func onFetchMeaningsSuccess(meanings: [Meaning]) {
        self.meanings = meanings
        presentMeanings(meanings)
    }
    
    func onFetchMeaningsFailure(message: String) {
        
    }
}
