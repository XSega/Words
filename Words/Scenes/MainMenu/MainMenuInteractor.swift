//
//  MainMenuInteractor.swift
//  Words
//
//  Created by Sergey Ilyushin on 28/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IMainMenuInteractor {
    func logout()
}

class MainMenuInteractor: IMainMenuInteractor {
    weak var view: IMainMenuView!
    var router: IMainMenuRouter!
    
    func logout() {
        resetUserSettings()
        router.routeToLogin()
    }
    
    func resetUserSettings() {
        UserDefaults.standard.removeObject(forKey: Keys.User.Email)
        UserDefaults.standard.removeObject(forKey: Keys.User.Token)
        UserDefaults.standard.removeObject(forKey: Keys.User.Dictionary)
        LocalDataManager.removeAllUserWords()
    }
}
