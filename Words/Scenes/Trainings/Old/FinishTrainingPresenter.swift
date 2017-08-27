//
//  FinishTrainingPresenter.swift
//  Words
//
//  Created by Sergey Ilyushin on 27/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol IFinishTrainingPresenter {
    func viewDidLoad()
    func didRestartTraining()
    func didFinishTraining()
}

class FinishTrainingPresenter: IFinishTrainingPresenter {
    
    // MARK: Public Vars
    
    var mistakes: Int = 0
    var words: Int = 0
    
    weak var view: IFinishTrainingView?
    var router: IFinishTrainingRouter!
    
    func viewDidLoad() {
        view?.showMistakes(mistakes: mistakes, words: words)
    }
    
    func didRestartTraining() {
        router.restartTraining()
    }
    
    func didFinishTraining() {
        router.finishTraining()
    }
}
