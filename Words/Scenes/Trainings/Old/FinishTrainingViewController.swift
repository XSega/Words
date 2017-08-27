//
//  FinishTrainingViewController.swift
//  Words
//
//  Created by Sergey Ilyushin on 23/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IFinishTrainingView: class {
    func showMistakes(mistakes: Int, words: Int)
}

class FinishTrainingViewController: UIViewController, IFinishTrainingView {
    
    // MARK: Public vars
    
    var presenter: IFinishTrainingPresenter!
    
    // MARK: IBOutlets
    
    @IBOutlet weak var mistakesLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    
    override func viewDidLoad() {
        presenter.viewDidLoad()
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    // MARK: IFinishTrainingView protocol
    
    func showMistakes(mistakes: Int, words: Int) {
        mistakesLabel.text = "\(mistakes)"
        wordsLabel.text = "\(words)"
    }
    
    // MARK: IBActions
    
    @IBAction func finishAction() {
        presenter.didFinishTraining()
    }
    
    @IBAction func restartAction() {
        presenter.didRestartTraining()
    }
}
