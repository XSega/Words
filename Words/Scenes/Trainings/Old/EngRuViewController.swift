//
//  EngRuViewController.swift
//  Words
//
//  Created by Sergey Ilyushin on 22/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IEngRuView: class {
    func displayMeaning(text: String, translations: [String], imageData: Data?, soundData: Data?)
    func displayCorrectAlert(attemps: Int)
    func displayWrongAlert(attemps: Int)
    func finish()
}

class EngRuViewController: TrainingViewController {

    // MARK:- Public Vars
    
    weak var presenter: IEngRuTraining!
    
    // MARK:- Outlets
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var translateField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var meaningContainer: UIView!
    
    @IBOutlet weak var variant1Button: UIButton!
    @IBOutlet weak var variant2Button: UIButton!
    @IBOutlet weak var variant3Button: UIButton!
    @IBOutlet weak var variant4Button: UIButton!
    
    // MARK:- Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        presenter.start()
    }
    
    override func didRestartTraining() {
        presenter.start()
    }
    
    override func prepareFinish(controller: FinishTrainingViewController) {
      //  controller.mistakes = presenter.mistakes
     //   controller.words = presenter.words
    }
    
    // MARK:- IBActions
    
    @IBAction func nextAction(_ button: UIButton) {
   
    }

    @IBAction func checkVariant1(_ button: UIButton) {
        presenter.checkTranslation(text: button.title(for: .normal)!)
    }
    
    @IBAction func checkVariant2(_ button: UIButton) {
        presenter.checkTranslation(text: button.title(for: .normal)!)
    }
    
    @IBAction func checkVariant3(_ button: UIButton) {
        presenter.checkTranslation(text: button.title(for: .normal)!)
    }
    
    @IBAction func checkVariant4(_ button: UIButton) {
        presenter.checkTranslation(text: button.title(for: .normal)!)
    }
    
    @IBAction func closeAction(_ button: UIButton) {
        presenter.finish()
    }
}

// MARK: IEngRuView interface

extension EngRuViewController: IEngRuView {
    
    func displayMeaning(text: String, translations: [String], imageData: Data?, soundData: Data?){
        self.meaningContainer.backgroundColor = UIColor.blueBackground
       
        self.textLabel.text = text
        self.variant1Button.setTitle(translations[0], for: .normal)
        self.variant2Button.setTitle(translations[1], for: .normal)
        self.variant3Button.setTitle(translations[2], for: .normal)
        self.variant4Button.setTitle(translations[3], for: .normal)
        
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

