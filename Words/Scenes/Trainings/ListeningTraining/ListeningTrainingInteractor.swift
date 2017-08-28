//
//  ListeningTrainingInteractor.swift
//  Words
//
//  Created by Sergey Ilyushin on 30/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IListeningTrainingInteractor {
    func start()
    func checkTranslation(text: String?)
    func skipMeaning()
    func listenAgain()
}

class ListeningTrainingInteractor: IListeningTrainingInteractor, ITrainingDataStore {
    var presenter: IListeningTrainingPresenter!
    
    // MARK: Training vars
    
    var meanings: [Meaning]!
    var mistakes: Int = 0
    var words: Int = 0
    var learnedIdentifiers = [Int]()
    
    // MARK: Private vars
    
    fileprivate var currentMeaningIndex: Int = 0
    
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
    
    func checkTranslation(text: String?) {
        let meaning = meanings[currentMeaningIndex]
        
        guard let text = text, text != "" else {
            didSkipSelection(meaning: meaning)
            return
        }
        
        if meaning.text.lowercased() == text.lowercased() {
            didCorrectSelection(meaning: meaning)
        } else {
            didWrongSelection(meaning: meaning, wrongText: text)
        }
    }
    
    func listenAgain() {
        let meaning = meanings[currentMeaningIndex]
        presenter.presentMeaningSound(meaning: meaning)
    }
    
    func skipMeaning(){
        let meaning = meanings[currentMeaningIndex]
        didSkipSelection(meaning: meaning)
    }
    
    // MARK: Private func
    
    fileprivate func didCorrectSelection(meaning: Meaning) {
        presenter.presentCorrectAlert(meaning: meaning)
        learnedIdentifiers.append(meaning.identifier)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            self.nextPair()
        }
    }
    
    fileprivate func didWrongSelection(meaning: Meaning, wrongText: String) {
        mistakes += 1
        presenter.presentWrongAlert(meaning: meaning, wrongText: wrongText)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            self.nextPair()
        }
    }
    
    fileprivate func didSkipSelection(meaning: Meaning) {
        mistakes += 1
        presenter.presentSkipAlert(meaning: meaning)
        
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
        presenter.present(meaning: meaning)
        words += 1
    }
}
