//
//  LoginEmailRouter.swift
//  Words
//
//  Created by Sergey Ilyushin on 27/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol ILoginEmailRouter: class {
    func routeToLoginToken(segue: UIStoryboardSegue)
}

protocol ILoginEmailDataPassing
{
    var dataStore: ILoginEmailDataStore! { get }
}

class LoginEmailRouter: NSObject, ILoginEmailRouter {
    weak var viewController: LoginEmailViewController!
    var dataStore: ILoginEmailDataStore!
    
    // MARK: Routing
    
    func routeToLoginToken(segue: UIStoryboardSegue)
    {
        if let destinationVC = segue.destination as? LoginTokenViewController, var destinationDS = destinationVC.router!.dataStore {
            passDataToLoginToken(source: dataStore, destination: &destinationDS)
        }
    }
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: MainMenuViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    func passDataToLoginToken(source: ILoginEmailDataStore, destination: inout ILoginTokenDataStore)
    {
        destination.email = source.email
    }

}
