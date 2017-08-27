//
//  MainMenuPresenter.swift
//  Words
//
//  Created by Sergey Ilyushin on 28/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IMainMenuPresenter {
    func presentSomething(text: String)
}

class MainMenuPresenter: IMainMenuPresenter {
    weak var view: IMainMenuView!
  
    // MARK: Do something
  
    func presentSomething(text: String) {
     
    }
}
