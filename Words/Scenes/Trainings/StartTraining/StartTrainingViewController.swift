//
//  StartTrainingViewController.swift
//  Words
//
//  Created by Sergey Ilyushin on 30/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

let meaningIds = [36862, 236865, 236866, 236870, 236869, 202760, 129723, 236877, 236880, 234325, 236884, 236886, 236888, 64923, 124532, 236895, 180348, 35973, 216966, 153400, 236896, 21808, 88434, 236898, 236940, 236941, 1919, 236942, 236943, 236944, 236945, 236939, 236938, 236937, 37689, 37692, 236936, 236935, 193211, 72274, 236933, 25132, 236931, 44188, 125761, 236930, 194783, 236929, 236928, 236927, 215389, 236926, 82919, 236924, 236923, 236922, 9867]

protocol IStartTrainingView: class
{
    func displayMeanings(meanings: [Meaning])
    func displayError(text: String)
}

class StartTrainingViewController: UIViewController, IStartTrainingView
{
    var interactor: IStartTrainingInteractor!
    var router: (NSObjectProtocol & IStartTrainingRouter & IStartTrainingDataPassing)!

    override var prefersStatusBarHidden : Bool {
        return true
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
        let interactor = StartTrainingInteractor()
        let presenter = StartTrainingPresenter()
        let router = StartTrainingRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.view = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        let apiDataManager = APIDataManager(api: SkyengAPI(session: AlamofireSession()))
        let localDataManager = LocalDataManager()
        let manager = MeaningsManager()
        manager.interactor = interactor
        manager.apiDataManager = apiDataManager
        manager.localDataManager = localDataManager
        
        interactor.manager = manager
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
        start()
    }
    
    func start() {
        interactor.fetchMeanings()
    }

    
    // MARK: IStartTrainingView
    func displayMeanings(meanings: [Meaning]) {
        router.routeToTraining()
    }
    
    func displayError(text: String) {
        
    }
    
    // MARK: Navigation
    
    @IBAction func unwindToStartTrainig(segue:UIStoryboardSegue)
    {
        start()
    }
}
