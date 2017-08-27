//
//  LaunchAppRouter
//  Words
//
//  Created by Sergey Ilyushin on 27/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol ILaunchAppRouter: class {
    func routeToLogin()
    func routeToMainMenu()
}

protocol ILaunchAppDataPassing
{

}

class LaunchAppRouter: NSObject, ILaunchAppRouter, ILaunchAppDataPassing {
    weak var viewController: LaunchAppViewController?
    
    // MARK: Routing
    func routeToLogin()
    {
        if let window = UIApplication.shared.delegate?.window {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            
            UIView.transition(with: window!,
                              duration: 0.5,
                              options: UIViewAnimationOptions.transitionFlipFromRight,
                              animations:  {
                                window?.rootViewController = storyboard.instantiateInitialViewController()
            }, completion: nil)
        }
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
