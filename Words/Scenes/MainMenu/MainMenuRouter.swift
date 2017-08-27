//
//  MainMenuRouter.swift
//  Words
//
//  Created by Sergey Ilyushin on 28/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

@objc protocol IMainMenuRouter {
    func routeToLogin()
}

class MainMenuRouter: NSObject, IMainMenuRouter {
    weak var viewController: MainMenuViewController!

    // MARK: Routing

    func routeToStartEngRuTraining(segue: UIStoryboardSegue) {
        if let destinationVC = segue.destination as? StartTrainingViewController {
            destinationVC.router.segueIdentifier = "EngRuTraining"
        }
    }
    
    func routeToStartSprintTraining(segue: UIStoryboardSegue) {
        if let destinationVC = segue.destination as? StartTrainingViewController {
            destinationVC.router.segueIdentifier = "SprintTraining"
        }
    }
    
    func routeToStartRuEngTraining(segue: UIStoryboardSegue) {
        if let destinationVC = segue.destination as? StartTrainingViewController {
            destinationVC.router.segueIdentifier = "RuEngTraining"
        }
    }
    
    func routeToStartListeningTraining(segue: UIStoryboardSegue) {
        if let destinationVC = segue.destination as? StartTrainingViewController {
            destinationVC.router.segueIdentifier = "ListeningTraining"
        }
    }
    
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
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    //func navigateToSomewhere(source: MainMenuViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: IMainMenuDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
