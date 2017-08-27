//
//  EngRuViewController.swift
//  Words
//
//  Created by Sergey Ilyushin on 22/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IListeningView: class {
    func display(meaning: String, imageData: Data?, soundData: Data?)
    func displayCorrectAlert(attemps: Int)
    func displayWrongAlert(attemps: Int)
    func finish()
}

class ListeningViewController: TrainingViewController {

    // MARK:- Public Vars
    
    weak var presenter: IListeningTraining!
    
    // MARK:- Outlets
    
    @IBOutlet weak var textField: UITextField!
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
        //controller.mistakes = presenter.mistakes
       // controller.words = presenter.words
    }
    
    // MARK:- IBActions
    
    @IBAction func checkAction(_ button: UIButton) {
        
    }
    
    @IBAction func nextAction(_ button: UIButton) {
        
    }

    @IBAction func checkVariant1(_ button: UIButton) {
        
    }
    
    @IBAction func checkVariant2(_ button: UIButton) {
        
    }
    
    @IBAction func checkVariant3(_ button: UIButton) {
        
    }
    
    @IBAction func checkVariant4(_ button: UIButton) {
        
    
    }
}

// MARK: IListeningView interface

extension ListeningViewController: IListeningView {
    
    func display(meaning: String, imageData: Data?, soundData: Data?) {
        self.meaningContainer.backgroundColor = UIColor.blueBackground
        self.translateField.text = meaning
        
        if let imageData = imageData {
            self.imageView.image = UIImage(data: imageData)
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

