//
//  ViewController.swift
//  Words
//
//  Created by Sergey Ilyushin on 19/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IRuEngView: class {
    func displayMeaning(translate: String, imageData: Data?, soundData: Data?)
    func displayCorrectAlert(attemps: Int)
    func displayWrongAlert(attemps: Int)
    func finish()
}

class RuEngViewController: TrainingViewController {

    // MARK:- Public Vars
    
    weak var presenter: IRuEngTraining!
    
    // MARK:- Outlets
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var translateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var meaningContainer: UIView!
    
    // MARK:- Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.start()
        
        self.textField.becomeFirstResponder()
    }
    
    override func didRestartTraining() {
        presenter.start()
    }
    
    override func prepareFinish(controller: FinishTrainingViewController) {
       // controller.mistakes = presenter.mistakes
       // controller.words = presenter.words
    }

    // MARK:- Override methods
    
    @IBAction func checkAction(_ button: UIButton) {
        presenter.checkTranslation(text: textField.text!)
    }
    
    @IBAction func nextAction(_ button: UIButton) {
        //textField.resignFirstResponder()
    }
    
    @IBAction func closeAction(_ button: UIButton) {
        presenter.finish()
    }
}

// MARK: RuEngView interface

extension RuEngViewController: IRuEngView {
    
    func displayMeaning(translate: String, imageData: Data?, soundData: Data?) {
        self.meaningContainer.backgroundColor = UIColor.blueBackground
        self.translateLabel.text = translate
        self.textField.text = nil
        
        if let imageData = imageData {
            self.imageView.image = UIImage(data: imageData)
        }
        if let soundData = soundData {
            playSound(data: soundData)
        }
        self.view.isUserInteractionEnabled = true
    }
    
    func displayCorrectAlert(attemps: Int)
    {
        meaningContainer.backgroundColor = UIColor.correct
        
        playSound(name: "correctSound")
    }
    
    func displayWrongAlert(attemps: Int)
    {
        meaningContainer.backgroundColor = UIColor.wrong

        playSound(name: "wrongSound")
    }
    
    func finish() {
        performSegue(withIdentifier: "finishSegue", sender: self)
    }
}

