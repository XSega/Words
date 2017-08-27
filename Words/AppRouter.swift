//
//  AppRouter.swift
//  Words
//
//  Created by Sergey Ilyushin on 27/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

class AppRouter: NSObject {

    let api = SkyengAPI(session: AlamofireSession())
    
    func startApp(window: UIWindow?) {
        if let _ = UserDefaults.standard.string(forKey: Keys.User.Dictionary) {
            navigateToMenu(window: window)
            return
        }
        
        // Get stored user data
        let email = UserDefaults.standard.string(forKey: Keys.User.Email)
        let token = UserDefaults.standard.string(forKey: Keys.User.Token)
        
        if let _ = email, let _ = token {
            navigateToLaunch(window: window)
        } else {
            navigateToLogin(window: window)
        }
        
    }
    
    func navigateToLaunch(window: UIWindow?) {
        window?.makeKeyAndVisible()
        
        let storyboard = UIStoryboard(name: "Launch", bundle: nil)
        window?.rootViewController = storyboard.instantiateInitialViewController()
    }
    
    func navigateToMenu(window: UIWindow?) {
        window?.makeKeyAndVisible()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window?.rootViewController = storyboard.instantiateInitialViewController()

    }
    
    func navigateToLogin(window: UIWindow?) {
        window?.makeKeyAndVisible()
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        window?.rootViewController = storyboard.instantiateInitialViewController()

    }
}
