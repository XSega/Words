//
//  FinishTrainingInteractor.swift
//  Words
//
//  Created by Sergey Ilyushin on 29/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IFinishTrainingInteractor {
    func start()
}

protocol IFinishTrainingDataStore {
    var mistakes: Int { get set }
    var words: Int { get set }
    var learnedIdentifiers: [Int]! { get set }
}

class FinishTrainingInteractor: IFinishTrainingInteractor, IFinishTrainingDataStore {
    
    var presenter: IFinishTrainingPresenter!
    var dataManager: ILocalDataManager!
    
    var mistakes: Int = 0
    var words: Int = 0
    var learnedIdentifiers: [Int]!
    
    // MARK: Do something
  
    func start() {
        presenter?.present(mistakes: mistakes, words: words)
        dataManager.updateUserWordsProgress(identifiers: learnedIdentifiers)
    }
}
