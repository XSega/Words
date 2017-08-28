//
//  ListeningTrainingPresenter.swift
//  Words
//
//  Created by Sergey Ilyushin on 30/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IListeningTrainingPresenter {
    func present(meaning: Meaning)
    func presentCorrectAlert(meaning: Meaning)
    func presentWrongAlert(meaning: Meaning, wrongText: String)
    func presentSkipAlert(meaning: Meaning)
    func presentMeaningSound(meaning: Meaning)
    func presentFinish()
}

class ListeningTrainingPresenter: TrainingPresenter, IListeningTrainingPresenter {
    weak var view: IListeningTrainingView!
  
    // MARK: IEngRuTrainingPresenter
    
    func present(meaning: Meaning) {
        view.display()
        
        if let soundData = meaning.soundData {
            playSound(data: soundData)
        }
    }
    func presentCorrectAlert(meaning: Meaning) {
        view.display(text: meaning.text, translation: meaning.translation, imageData: meaning.imageData)
        view.displayCorrectAlert()
        playCorrectSound()
    }
    
    func presentWrongAlert(meaning: Meaning, wrongText: String) {
        view.display(text: meaning.text, translation: meaning.translation, imageData: meaning.imageData)
        view.displayWrongAlert(text: wrongText)
        playWrongSound()
    }

    func presentSkipAlert(meaning: Meaning) {
        view.display(text: meaning.text, translation: meaning.translation, imageData: meaning.imageData)
        view.displaySkipAlert()
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
