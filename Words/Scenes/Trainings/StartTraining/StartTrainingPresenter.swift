//
//  StartTrainingPresenter.swift
//  Words
//
//  Created by Sergey Ilyushin on 30/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IStartTrainingPresenter {
    func present(meanings: [Meaning]?)
    func presentError(text: String)
}

class StartTrainingPresenter: IStartTrainingPresenter {
    weak var view: IStartTrainingView!
  
    // MARK: Do something
  
    func present(meanings: [Meaning]?) {
        if let meanings = meanings {
            view.displayMeanings(meanings: meanings)
        } else {
            view.displayError(text: "Error loading meanings")
        }
    }
    
    func presentError(text: String) {
        view.displayError(text: "Error loading meanings")
    }
}
