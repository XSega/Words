//
//  SprintTraining.swift
//  Words
//
//  Created by Sergey Ilyushin on 23/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol ISprintTrainingPresenter2: class {
    
    var mistakes: Int { get set }
    var words: Int { get set }
    
    func start()
    func finish()
    func selectWrongAction()
    func selectCorrectAction()
    func selectSkipAction()
}

class SprintTrainingPresenter2: ISprintTrainingPresenter2 {
    
    // MARK: Public Vars
    weak var view: ISprintView!
    var interactor: ITrainingInteractor!
    var router: ITrainingRouter!
    
    public var attemps: Int = 3
    public var mistakes: Int = 0
    public var words: Int = 0
    
    public var meanings: [Meaning]!

    
    // MARK:- Private vars
    
    fileprivate var currentMeaningIndex: Int = 0
    fileprivate var currentTranlsation: String = ""
    
    // MARK: Public func
    
    func start() {
        currentMeaningIndex = 0
        attemps = 3
        mistakes = 0
        words = 1
        
        router.presentFinishScreen(mistakes: mistakes, words: words)
      //  interactor.fetchMeanings()
       // displayPair()
    }
    
    func finish() {
        currentMeaningIndex = 0
        attemps = 3
       // view.finish()
        
        router.presentFinishScreen(mistakes: mistakes, words: words)
    }
    
    func selectWrongAction() {
        let meaning = meanings[currentMeaningIndex]
        
        if meaning.translation != currentTranlsation {
            didCorrectSelection()
        } else {
            didWrongSelection()
        }
    }
    
    func selectCorrectAction() {
        let meaning = meanings[currentMeaningIndex]
        
        if meaning.translation == currentTranlsation {
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
        attemps = min(attemps + 1, 3)
        view?.displayCorrectAlert(attemps: attemps)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
            self.nextPair()
        }
    }
    
    fileprivate func didWrongSelection() {
        attemps -= 1
        mistakes += 1
        view?.displayWrongAlert(attemps: attemps)
        
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
        words += 1
        
        guard currentMeaningIndex < meanings.count else {
            finish()
            return
        }
        displayPair()
    }
    
    fileprivate func displayPair() {
        let meaning = meanings[currentMeaningIndex]
        currentTranlsation = meaning.randomTranslation()
        
        view?.display(meaning: meaning.text, translate: currentTranlsation)
    }
}

// MARK:- SprintInteractorOutput

extension SprintTrainingPresenter2: ITrainingInteractorOutput {
    func onFetchMeaningsSuccess(meanings: [Meaning]) {
        self.meanings = meanings
        displayPair()
    }
    
    func onFetchMeaningsFailure(message: String) {
        
    }
}
