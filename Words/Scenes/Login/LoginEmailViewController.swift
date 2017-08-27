//
//  LoginEmailViewController.swift
//  Words
//
//  Created by Sergey Ilyushin on 25/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit
import RSLoadingView

protocol ILoginEmailView: class {
    func displayError(text: String)
    func displaySuccessful(text: String)
}

class LoginEmailViewController: UIViewController {

    // MARK:- IBOutlets
    
    @IBOutlet weak var emailField: UITextField!
    
    // MARK:- Public vars
    
    var interactor: ILoginEmailInteractor!
    var router: (NSObjectProtocol & ILoginEmailRouter)!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = LoginEmailInteractor()
        let router = LoginEmailRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.view = viewController
        
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        emailField.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        emailField.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        emailField.resignFirstResponder()
    }
    
    // MARK:- IBAction
    
    @IBAction func nextAction(_ button: UIButton) {
        interactor.next(email: emailField.text)
    }

    @IBAction func unwindToLoginEmail(segue:UIStoryboardSegue)
    {
        
    }
}

// MARK:- ILoginEmailView interface

extension LoginEmailViewController: ILoginEmailView {
    
    func displaySuccessful(text: String) {
        emailField.borderWidth = 0
        emailField.borderColor = UIColor.clear
        
        performSegue(withIdentifier: "LoginToken", sender: nil)
    }

    func displayError(text: String) {
        emailField.borderWidth = 2
        emailField.borderColor = UIColor.red
    }
}
