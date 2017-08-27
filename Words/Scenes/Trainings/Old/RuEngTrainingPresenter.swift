//
//  RuEngTrainingPresenter.swift
//  Words
//
//  Created by Sergey Ilyushin on 24/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol IRuEngTraining: class {
    
    var mistakes: Int { get set }
    var words: Int { get set }
    
    func start()
    func finish()
    func checkTranslation(text: String)
    func selectSkipAction()
}

class RuEngTrainingPresenter: IRuEngTraining {
    
    // MARK:- Public Vars
    
    public var attemps: Int = 3
    public var mistakes: Int = 0
    public var words: Int = 0
    
    public var meanings: [Meaning]!
    weak var view: IRuEngView!
    
    // MARK:- Private vars
    
    fileprivate var currentMeaningIndex: Int = 0
    fileprivate var currentTranlsation: String = ""
    
    // MARK:- Public func
    
    func start() {
        currentMeaningIndex = 0
        attemps = 3
        mistakes = 0
        words = 1
        displayPair()
    }
    
    func finish() {
        currentMeaningIndex = 0
        attemps = 3
        view.finish()
    }
    
    func checkTranslation(text: String) {
        let meaning = meanings[currentMeaningIndex]
        if meaning.text == text {
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
        
        view?.displayMeaning(translate: meaning.translation, imageData: meaning.imageData, soundData: meaning.soundData)
    }
}
