//
//  SprintTrainingViewController.swift
//  Words
//
//  Created by Sergey Ilyushin on 28/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol ISprintTrainingView: class
{
    func display(meaning: String?, translation: String?)
    func displayCorrectAlert(attemps: Int)
    func displayWrongAlert(attemps: Int)
    func displayFinish()
}

class SprintTrainingViewController: TrainingViewController, ISprintTrainingView
{
    // MARK: IBoutlets
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var translateLabel: UILabel!
    @IBOutlet weak var timerView: SRCountdownTimer!
    @IBOutlet weak var meaningContainer: UIView!
    
    @IBOutlet weak var attemp1View: UIImageView!
    @IBOutlet weak var attemp2View: UIImageView!
    @IBOutlet weak var attemp3View: UIImageView!
    
    // MARK: Scene vars
    
    var interactor: ISprintTrainingInteractor!
    var router: (NSObjectProtocol & ITrainingRouter & ITrainingDataPassing)!

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
        let interactor = SprintTrainingInteractor()
        let presenter = SprintTrainingPresenter()
        let router = TrainingRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
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

        start()
        
        // Time customization
        timerView.delegate = self
        timerView.lineWidth = 8
        timerView.lineColor = UIColor.blueBackground
        timerView.labelFont = UIFont.systemFont(ofSize: 96, weight: UIFontWeightRegular)
    }
    
    func start() {
        interactor.start()
    }
    
    func restart() {
        interactor.restart()
    }
    
    func skipMeaning() {
        interactor.selectSkipAction();
    }
    
    func finish() {
        self.view.isUserInteractionEnabled = true
        performSegue(withIdentifier: "FinishTraining", sender: self)
    }
    
    func selectWrongAction() {
        self.view.isUserInteractionEnabled = false
        timerView.end()
        interactor.selectWrongAction();
    }
    
    func selectCorrectAction() {
        self.view.isUserInteractionEnabled = false
        timerView.end()
        interactor.selectCorrectAction()
    }

    func updateAttempsBar(attemps: Int) {
        attemp1View.image = attemps > 0 ? #imageLiteral(resourceName: "correct") : #imageLiteral(resourceName: "wrong")
        attemp2View.image = attemps > 1 ? #imageLiteral(resourceName: "correct") : #imageLiteral(resourceName: "wrong")
        attemp3View.image = attemps > 2 ? #imageLiteral(resourceName: "correct") : #imageLiteral(resourceName: "wrong")
    }
    
    // MARK: ISprintTrainingView
    
    func display(meaning: String?, translation: String?) {
        meaningContainer.backgroundColor = UIColor.blueBackground
        
        textLabel.text = meaning
        translateLabel.text = translation
        
        timerView.start(beginingValue: 3, interval: 1)
        
        self.view.isUserInteractionEnabled = true

    }
    
    func displayCorrectAlert(attemps: Int) {
        meaningContainer.backgroundColor = UIColor.correct
        updateAttempsBar(attemps: attemps)
    }
    
    func displayWrongAlert(attemps: Int) {
        meaningContainer.backgroundColor = UIColor.wrong
        updateAttempsBar(attemps: attemps)
    }
    
    func displayFinish() {
        performSegue(withIdentifier: "FinishTraining", sender: self)
    }
    
    // MARK:- IBActions
    
    @IBAction func wrongAction(_ button: UIButton) {
        selectWrongAction()
    }
    
    @IBAction func correctAction(_ button: UIButton) {
        selectCorrectAction()
    }
    
    @IBAction func closeAction(_ button: UIButton) {
        timerView.end()
        finish()
    }
}


// MARK: SRCountdownTimerDelegate delegate

extension SprintTrainingViewController: SRCountdownTimerDelegate {
    func timerDidEnd()
    {
        skipMeaning()
    }

}


