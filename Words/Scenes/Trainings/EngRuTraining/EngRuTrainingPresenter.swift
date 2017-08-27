//
//  EngRuTrainingPresenter.swift
//  Words
//
//  Created by Sergey Ilyushin on 30/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

class EngRuTrainingPresenter: TrainingPresenter, ITrainingPresenter {
    weak var view: IEngRuTrainingView!
  
    // MARK: IEngRuTrainingPresenter
    
    func present(meaning: Meaning, variants: [Variant]) {
        view.display(word: meaning.text)
        view.display(translations: variants.map({$0.translation}))
        
        if let soundData = meaning.soundData {
            playSound(data: soundData)
        }
    }
    
    func presentCorrectAlert(meaning: Meaning, correctIndex: Int) {
        view.display(imageData: meaning.imageData)
        view.displayCorrectAlert()
        view.displayCorrectVariant(index: correctIndex)
        playCorrectSound()
    }
    
    func presentWrongAlert(meaning: Meaning, correctIndex: Int, wrongIndex: Int) {
        view.display(imageData: meaning.imageData)
        view.displayWrongAlert()
        view.displayCorrectVariant(index: correctIndex)
        view.displayWrongVariant(index: wrongIndex)
        playWrongSound()
    }
    
    func presentSkipAlert(meaning: Meaning, correctIndex: Int) {
        view.display(imageData: meaning.imageData)
        view.displaySkipAlert()
        view.displayCorrectVariant(index: correctIndex)
        playWrongSound()
    }

    func presentMeaningSound(meaning: Meaning) {
        if let soundData = meaning.soundData {
            playSound(data: soundData)
        }
    }
    
    func presentFinish() {
        view.displayFinish()
    }
}
