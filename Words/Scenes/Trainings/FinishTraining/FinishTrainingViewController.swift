//
//  FinishTrainingViewController.swift
//  Words
//
//  Created by Sergey Ilyushin on 29/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IFinishTrainingView: class
{
    func displayMistakes(mistakes: Int, words: Int)
}

class FinishTrainingViewController: UIViewController, IFinishTrainingView
{
    var interactor: IFinishTrainingInteractor!
    var router: (NSObjectProtocol & IFinishTrainingRouter & IFinishTrainingDataPassing)!

    // MARK: IBOutlets
    @IBOutlet weak var mistakesLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
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
        let interactor = FinishTrainingInteractor()
        let presenter = FinishTrainingPresenter()
        let router = FinishTrainingRouter()
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        interactor.dataManager = LocalDataManager()
        
        presenter.view = viewController
        router.viewController = viewController
        router.dataStore = interactor
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
        
        interactor.start()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    // MARK: IFinishTrainingView protocol
    
    func displayMistakes(mistakes: Int, words: Int) {
        mistakesLabel.text = "\(mistakes)"
        wordsLabel.text = "\(words)"
        resultLabel.text = mistakes > 0 ? "😢" : "🏆"
    }
    
    // MARK: IBActions
    
    @IBAction func finishAction() {
      // presenter.didFinishTraining()
        
    }
    
    @IBAction func restartAction() {
        //presenter.didRestartTraining()
    }
}
