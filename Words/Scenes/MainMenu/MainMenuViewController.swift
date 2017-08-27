//
//  MainMenuViewController.swift
//  Words
//
//  Created by Sergey Ilyushin on 28/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IMainMenuView: class
{
   
}

class MainMenuViewController: UIViewController, IMainMenuView
{
    var interactor: IMainMenuInteractor!
    var router: (NSObjectProtocol & IMainMenuRouter)!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = MainMenuInteractor()

        let router = MainMenuRouter()
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.view = viewController
        interactor.router = router
        
        router.viewController = viewController
    }
  
    // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: IBActions
    
    @IBAction func logoutAction(_ button: UIButton) {
        interactor.logout()
    }
    
    // MARK: Navigation segue
    
    @IBAction func unwindToMainMenu(segue:UIStoryboardSegue) {
        
    }
}
