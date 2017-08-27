//
//  SprintTrainingPresenter.swift
//  Words
//
//  Created by Sergey Ilyushin on 28/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol ISprintTrainingPresenter {
    func present(meaning: String?, translation: String?)
    func presentCorrectAlert(attemps: Int)
    func presentWrongAlert(attemps: Int)
    func presentFinish()
}

class SprintTrainingPresenter: TrainingPresenter, ISprintTrainingPresenter {
    weak var view: ISprintTrainingView!
  
    // MARK: ISprintTrainingPresenter
  
    func present(meaning: String?, translation: String?) {
        view.display(meaning: meaning, translation: translation)
    }
    
    func presentCorrectAlert(attemps: Int) {
        view.displayCorrectAlert(attemps: attemps)
        playCorrectSound()
    }
    
    func presentWrongAlert(attemps: Int) {
        view.displayWrongAlert(attemps: attemps)
        playWrongSound()
    }
    
    func presentFinish() {
        view.displayFinish()
    }
}
