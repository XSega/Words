//
//  LoginTokenRouter.swift
//  Words
//
//  Created by Sergey Ilyushin on 27/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol ILoginTokenRouter: class {
    func routeToLoginEmail(segue: UIStoryboardSegue)
    func routeToMainMenu()
}

protocol ILoginTokenDataPassing
{
    var dataStore: ILoginTokenDataStore! { get }
}

class LoginTokenRouter: NSObject, ILoginTokenRouter, ILoginTokenDataPassing {
    weak var viewController: LoginTokenViewController?
    var dataStore: ILoginTokenDataStore!
    
    // MARK: Routing
    func routeToLoginEmail(segue: UIStoryboardSegue)
    {
        
    }
    
    func routeToMainMenu() {
        if let window = UIApplication.shared.delegate?.window {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
            UIView.transition(with: window!,
                              duration: 0.5,
                              options: UIViewAnimationOptions.transitionFlipFromRight,
                              animations:  {
                                    window?.rootViewController = storyboard.instantiateInitialViewController()
            }, completion: nil)
        }
    }
}
