//
//  LoginDictionaryViewController.swift
//  Words
//
//  Created by Sergey Ilyushin on 25/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit
import RSLoadingView

protocol ILoginDictionaryView: class {
    func displayError(text: String)
    func displaySuccessful(text: String)
    func displayLoadingProgress()
    func hideLoadingProgress()
}

class LoginDictionaryViewController: UIViewController {

    // MARK:- IBOutlets
    
    // MARK:- Public vars
    
    var interactor: ILoginDictionaryInteractor!
    var router: (NSObjectProtocol & ILoginDictionaryRouter & ILoginDictionaryDataPassing)!
    
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
        let interactor = LoginDictionaryInteractor()
        let router = LoginDictionaryRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.view = viewController
        
        router.viewController = viewController
        router.dataStore = interactor
        
        let localDataManager = LocalDataManager()
        let manager = UserWordsDictionaryManager()
        manager.interactor = interactor
        manager.localDataManager = localDataManager
        
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
    
    // MARK:- IBAction
    
    @IBAction func selectBeginnerLevel(button: UIButton) {
        interactor.selectBeginnerLevel()
    }
    
    @IBAction func selectElemenentaryLevel(button: UIButton) {
        interactor.selectElementaryLevel()
    }
    
    @IBAction func selectPreIntermediateLevel(button: UIButton) {
        interactor.selectPreIntermediateLevel()
    }
    
    @IBAction func selectIntermediateLevel(button: UIButton) {
        interactor.selectIntermediateLevel()
    }
}

extension LoginDictionaryViewController: ILoginDictionaryView {
    
    func displayLoadingProgress() {
        let loadingView = RSLoadingView()
        loadingView.show(on: view)
    }
    
    func hideLoadingProgress() {
        RSLoadingView.hide(from: view)
    }
    
    func displayError(text: String) {
        
    }
    func displaySuccessful(text: String) {
        router.routeToMainMenu()
    }
}
