//
//  FinishTrainingPresenter.swift
//  Words
//
//  Created by Sergey Ilyushin on 29/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IFinishTrainingPresenter {
    func present(mistakes: Int, words: Int)
}

class FinishTrainingPresenter: IFinishTrainingPresenter {
    weak var view: IFinishTrainingView!
  
    func present(mistakes: Int, words: Int) {
        view.displayMistakes(mistakes: mistakes, words: words)
    }
}
