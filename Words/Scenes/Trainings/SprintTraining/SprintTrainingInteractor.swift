//
//  SprintTrainingInteractor.swift
//  Words
//
//  Created by Sergey Ilyushin on 28/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol ISprintTrainingInteractor {
    func start()
    func restart()
    func finish()
    func selectSkipAction()
    func selectWrongAction()
    func selectCorrectAction()
}

class SprintTrainingInteractor: ISprintTrainingInteractor, ITrainingDataStore {
    
    // Scene vars
    var presenter: ISprintTrainingPresenter!
    
    // MARK: Training vars
    
    var meanings: [Meaning]!
    var attemps: Int = 3
    var mistakes: Int = 0
    var words: Int = 0
    var learnedIdentifiers = [Int]()
    
    // MARK: Private vars
    
    fileprivate var currentMeaningIndex: Int = 0
    fileprivate var currentTranlsation: String = ""
    
    // MARK: ISPrintTrainingInteractor
    
    func start() {
        currentMeaningIndex = 0
        attemps = 3
        mistakes = 0
        words = 0
        learnedIdentifiers.removeAll()
        presentCurrentMeaning()
    }
    
    func restart() {
        
    }
    
    func finish() {
        currentMeaningIndex = 0
        attemps = 3

        presenter.presentFinish()
    }
    
    func selectWrongAction() {
        let meaning = meanings[currentMeaningIndex]
        
        if meaning.translation != currentTranlsation {
            learnedIdentifiers.append(meaning.identifier)
            didCorrectSelection()
        } else {
            didWrongSelection()
        }
    }
    
    func selectCorrectAction() {
        let meaning = meanings[currentMeaningIndex]
        
        if meaning.translation == currentTranlsation {
            learnedIdentifiers.append(meaning.identifier)
            didCorrectSelection()
        } else {
            didWrongSelection()
        }
    }
    
    func selectSkipAction() {
        didWrongSelection()
    }
  
    // MARK: Private func
    
    fileprivate func didCorrectSelection() {
        presenter.presentCorrectAlert(attemps: attemps)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
            self.nextPair()
        }
    }
    
    fileprivate func didWrongSelection() {
        attemps -= 1
        mistakes += 1
        presenter.presentWrongAlert(attemps: attemps)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
            guard self.attemps > 0 else {
                self.finish()
                return
            }
            self.nextPair()
        }
    }
    
    fileprivate func nextPair() {
        currentMeaningIndex += 1
        
        guard currentMeaningIndex < meanings.count else {
            finish()
            return
        }
        presentCurrentMeaning()
    }
    
    fileprivate func presentCurrentMeaning() {
        let meaning = meanings[currentMeaningIndex]
        currentTranlsation = meaning.randomTranslation()
        
        presenter.present(meaning: meaning.text, translation: currentTranlsation)
        words += 1
    }
}
