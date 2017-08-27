//
//  TrainingContracts.swift
//  Words
//
//  Created by Sergey Ilyushin on 30/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol ITrainingDataStore {
    var mistakes: Int { get set }
    var words: Int { get set }
    var meanings: [Meaning]! { get set }
    var learnedIdentifiers: [Int] { get set }
}

protocol ITrainingPresenter {
    func present(meaning: Meaning, variants: [Alternative])
    func presentCorrectAlert(meaning: Meaning, correctIndex: Int)
    func presentWrongAlert(meaning: Meaning, correctIndex: Int, wrongIndex: Int)
    func presentSkipAlert(meaning: Meaning, correctIndex: Int)
    func presentMeaningSound(meaning: Meaning)
    func presentFinish()
}
