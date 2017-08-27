//
//  SprintViewController.swift
//  Words
//
//  Created by Sergey Ilyushin on 22/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol ISprintView: class {
    func display(meaning: String?, translate: String?)
    func displayCorrectAlert(attemps: Int)
    func displayWrongAlert(attemps: Int)
    func displayFinish()
}

class SprintViewController: TrainingViewController, SRCountdownTimerDelegate {

    // MARK:- Public Vars
    
    var presenter: ISprintTrainingPresenter!

    // MARK:- Outlets
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var translateLabel: UILabel!
    @IBOutlet weak var timerView: SRCountdownTimer!
    @IBOutlet weak var meaningContainer: UIView!
    
    @IBOutlet weak var attemp1View: UIImageView!
    @IBOutlet weak var attemp2View: UIImageView!
    @IBOutlet weak var attemp3View: UIImageView!
    
    // MARK:- Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Time customization
        timerView.delegate = self
        timerView.lineWidth = 8
        timerView.lineColor = UIColor.blueBackground
        timerView.labelFont = UIFont.systemFont(ofSize: 96, weight: UIFontWeightRegular)
        
        presenter.start()
    }
    
    override func didRestartTraining() {
        updateAttempsBar(attemps: 3)
        presenter.start()
    }
    
    override func prepareFinish(controller: FinishTrainingViewController) {
      //  controller.mistakes = presenter.mistakes
      //  controller.words = presenter.words
    }
    
    func updateAttempsBar(attemps: Int) {
        attemp1View.image = attemps > 0 ? #imageLiteral(resourceName: "correct") : #imageLiteral(resourceName: "wrong")
        attemp2View.image = attemps > 1 ? #imageLiteral(resourceName: "correct") : #imageLiteral(resourceName: "wrong")
        attemp3View.image = attemps > 2 ? #imageLiteral(resourceName: "correct") : #imageLiteral(resourceName: "wrong")
    }
    
    func selectWrongAction() {
        self.view.isUserInteractionEnabled = false
        timerView.end()
        presenter.selectWrongAction();
    }
    
    func selectCorrectAction() {
        self.view.isUserInteractionEnabled = false
        timerView.end()
        presenter.selectCorrectAction()
    }
    
    // MARK:- Timer delegate
    
    func timerDidEnd()
    {
        presenter.selectSkipAction();
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
        presenter.finish()
    }
}

// MARK: SprintView interface

extension SprintViewController: ISprintView {
    
    func display(meaning: String?, translate: String?)
    {
        meaningContainer.backgroundColor = UIColor.blueBackground
        
        textLabel.text = meaning
        translateLabel.text = translate
        
        timerView.start(beginingValue: 3, interval: 1)
        
        self.view.isUserInteractionEnabled = true
    }
    
    func displayCorrectAlert(attemps: Int)
    {
        meaningContainer.backgroundColor = UIColor.correct
        updateAttempsBar(attemps: attemps)
        
        playSound(name: "correctSound")
    }
    
    func displayWrongAlert(attemps: Int)
    {
        meaningContainer.backgroundColor = UIColor.wrong
        updateAttempsBar(attemps: attemps)
        
        playSound(name: "wrongSound")
    }
    
    func finish() {
        performSegue(withIdentifier: "finishSegue", sender: self)
    }
}
