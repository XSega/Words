//
//  EngRuTrainingInteractor.swift
//  Words
//
//  Created by Sergey Ilyushin on 30/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol ITrainingInteractor {
    func start()
    func checkVariantIndex(_ index: Int)
    func skipMeaning()
    func listenAgain()
}

class TrainingInteractor: ITrainingInteractor, ITrainingDataStore {
    var presenter: ITrainingPresenter!
    
    // MARK: Training vars
    
    var meanings: [Meaning]!
    var mistakes: Int = 0
    var words: Int = 0
    var learnedIdentifiers = [Int]()
    
    // MARK: Private vars
    
    fileprivate var currentMeaningIndex: Int = 0
    fileprivate var currentCorrectIndex: Int = 0
    fileprivate var currentVariants: [Variant]!
    
    // MARK: IEngRuTrainingInteractor
  
    func start() {
        currentMeaningIndex = 0
        mistakes = 0
        words = 0
        learnedIdentifiers.removeAll()
        presentCurrentMeaning()
    }
    
    func finish() {
        currentMeaningIndex = 0
        presenter.presentFinish()
    }
    
    func checkVariantIndex(_ index: Int) {
        let meaning = meanings[currentMeaningIndex]
        
        if currentCorrectIndex == index {
            didCorrectSelection(meaning: meaning, index: index)
        } else {
            didWrongSelection(meaning: meaning, correctIndex: currentCorrectIndex, wrongIndex: index)
        }
    }
    
    func listenAgain() {
        let meaning = meanings[currentMeaningIndex]
        presenter.presentMeaningSound(meaning: meaning)
    }
    
    func skipMeaning(){
        let meaning = meanings[currentMeaningIndex]
        
        didSkipAction(meaning: meaning, correctIndex: currentCorrectIndex)
    }
    
    // MARK: Private func
    
    fileprivate func didCorrectSelection(meaning: Meaning, index: Int) {
        presentCorrectAlert(meaning: meaning, correctIndex: index)
        learnedIdentifiers.append(meaning.identifier)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            self.nextPair()
        }
    }
    
    fileprivate func didWrongSelection(meaning: Meaning, correctIndex: Int, wrongIndex: Int) {
        mistakes += 1
        presentWrongAlert(meaning: meaning, correctIndex: correctIndex, wrongIndex: wrongIndex)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            self.nextPair()
        }
    }
    
    fileprivate func didSkipAction(meaning: Meaning, correctIndex: Int) {
        mistakes += 1
        presentSkipAlert(meaning: meaning, correctIndex: correctIndex)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
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
        
        currentVariants = meaning.randomVariants()
        if let index = currentVariants.map({$0.text}).index(of: meaning.text) {
            currentCorrectIndex = index
        }
        presenter.present(meaning: meaning, variants: currentVariants)
        
        words += 1
    }
    
    fileprivate func presentCorrectAlert(meaning: Meaning, correctIndex: Int) {
        presenter.presentCorrectAlert(meaning: meaning, correctIndex: correctIndex)
    }
    
    fileprivate func presentWrongAlert(meaning: Meaning,correctIndex: Int, wrongIndex: Int) {
        presenter.presentWrongAlert(meaning: meaning, correctIndex: correctIndex, wrongIndex: wrongIndex)
    }
    
    fileprivate func presentSkipAlert(meaning: Meaning, correctIndex: Int) {
        presenter.presentSkipAlert(meaning: meaning, correctIndex: correctIndex)
    }
}
