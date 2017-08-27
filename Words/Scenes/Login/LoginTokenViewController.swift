//
//  LoginTokenViewController.swift
//  Words
//
//  Created by Sergey Ilyushin on 25/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit
import RSLoadingView

protocol ILoginTokenView: class {
    func displayError(text: String)
    func displaySuccessful(text: String)
    func displayLoadingProgress()
    func hideLoadingProgress()
}

class LoginTokenViewController: UIViewController {

    // MARK:- IBOutlets
    
    @IBOutlet weak var tokenField: UITextField!
    @IBOutlet weak var sendTokenButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK:- Public vars
    
    var interactor: ILoginTokenInteractor!
    var router: (NSObjectProtocol & ILoginTokenRouter & ILoginTokenDataPassing)!
    
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
        let interactor = LoginTokenInteractor()
        let router = LoginTokenRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.view = viewController
        
        router.viewController = viewController
        router.dataStore = interactor
        
        let apiDataManager = WordsAPIDataManager(api: SkyengWordsAPI(session: AlamofireSession()))
        let localDataManager = LocalDataManager()
        let manager = UserWordsManager()
        manager.interactor = interactor
        manager.apiDataManager = apiDataManager
        manager.localDataManager = localDataManager
        
        let api = SkyengAuthAPI(session: AlamofireSession())
        interactor.api = api
        
        interactor.manager = manager
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
    
    override func viewDidAppear(_ animated: Bool) {
        tokenField.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        tokenField.resignFirstResponder()
    }
    
    // MARK:- IBAction
    
    @IBAction func loginAction(_ button: UIButton) {
        interactor.login(token: tokenField.text)
    }
    
    @IBAction func sendTokenAction(_ button: UIButton) {
        interactor.sendToken()
    }
}

extension LoginTokenViewController: ILoginTokenView {
    
    func displayLoadingProgress() {
        let loadingView = RSLoadingView()
        loadingView.show(on: view)
    }
    
    func hideLoadingProgress() {
        RSLoadingView.hide(from: view)
    }
    
    func displayError(text: String) {
        errorLabel.isHidden = false
        errorLabel.text = text
    }
    
    func displaySuccessful(text: String) {
        errorLabel.isHidden = true
        router.routeToMainMenu()
    }
}
