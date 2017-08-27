//
//  LaunchAppViewController
//  Words
//
//  Created by Sergey Ilyushin on 25/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit
import RSLoadingView

protocol ILaunchAppView: class {
    func displayError(text: String)
    func displaySuccessful(text: String)
    func displayLoadingProgress()
    func hideLoadingProgress()
}

class LaunchAppViewController: UIViewController {

    // MARK:- IBOutlets
    
    @IBOutlet weak var tokenField: UITextField!
    @IBOutlet weak var resignButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    // MARK:- Public vars
    
    var interactor: ILaunchAppInteractor!
    var router: (NSObjectProtocol & ILaunchAppRouter & ILaunchAppDataPassing)!
    
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
        let interactor = LaunchAppInteractor()
        let router = LaunchAppRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.view = viewController
        router.viewController = viewController
        
        let apiDataManager = WordsAPIDataManager(api: SkyengWordsAPI(session: AlamofireSession()))
        let localDataManager = LocalDataManager()
        let manager = UserWordsManager()
        manager.interactor = interactor
        manager.apiDataManager = apiDataManager
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
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        interactor.login()
        hideResignButton()
        //displayLoadingProgress()
    }

    func showResignButton() {
        resignButton.isHidden = false
    }
    
    func hideResignButton() {
        resignButton.isHidden = true
    }
    
    // MARK:- IBAction
    
    @IBAction func resignAction(_ button: UIButton) {
        router.routeToLogin()
    }
}

extension LaunchAppViewController: ILaunchAppView {
    
    func displayLoadingProgress() {
        let loadingView = RSLoadingView()
        loadingView.shouldDimBackground = false
        loadingView.show(on: view)
        hideResignButton()
    }
    
    func hideLoadingProgress() {
        RSLoadingView.hide(from: view)
    }
    
    func displayError(text: String) {
        showResignButton()
    }
    func displaySuccessful(text: String) {
        router.routeToMainMenu()
    }
}
