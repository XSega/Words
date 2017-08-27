//
//  EngRuTrainingViewController.swift
//  Words
//
//  Created by Sergey Ilyushin on 30/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IEngRuTrainingView: class {
    func display(word: String)
    func display(translations: [String])
    func display(imageData: Data?)
    func displayCorrectAlert()
    func displayWrongAlert()
    func displaySkipAlert()
    func displayCorrectVariant(index: Int)
    func displayWrongVariant(index: Int)
    func resetAlerts()
    func displayFinish()
}

class EngRuTrainingViewController: TrainingViewController, IEngRuTrainingView {
    // MARK:- Outlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var speakerContainer: UIView!
    @IBOutlet weak var meaningContainer: UIView!
    
    @IBOutlet weak var speakerButton: UIButton!
    @IBOutlet weak var variant1Button: UIButton!
    @IBOutlet weak var variant2Button: UIButton!
    @IBOutlet weak var variant3Button: UIButton!
    @IBOutlet weak var variant4Button: UIButton!
    
    // MARK: Scene vars
    
    var interactor: ITrainingInteractor!
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
        let interactor = TrainingInteractor()
        let presenter = EngRuTrainingPresenter()
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
    }

    // MARK: Do something

    func start() {
        interactor?.start()
    }

    func finish() {
        performSegue(withIdentifier: "FinishTraining", sender: self)
    }
    
    func checkVariant(index: Int) {
        interactor.checkVariantIndex(index)
        view.isUserInteractionEnabled = false
    }
    
    // MARK: IEngRuTrainingView
    
    func display(word: String) {
        resetAlerts()
        
        wordLabel.text = word
        
        alertLabel.text = "Remember the translation"
        alertLabel.textColor = UIColor.hintTextColor
        
        view.isUserInteractionEnabled = true
        
        speakerContainer.isHidden = false
        imageView.isHidden = true
    }
    
    func display(translations: [String]) {
        self.variant1Button.setTitle(translations[0], for: .normal)
        self.variant2Button.setTitle(translations[1], for: .normal)
        self.variant3Button.setTitle(translations[2], for: .normal)
        self.variant4Button.setTitle(translations[3], for: .normal)
    }
    
    func display(imageData: Data?){
        speakerContainer.isHidden = true
        imageView.isHidden = false
        
        if let imageData = imageData {
            self.imageView.image = UIImage(data: imageData)
        }
    }
    
    func displayCorrectAlert() {
        meaningContainer.backgroundColor = UIColor.correct
        alertLabel.text = "Your answered correctly"
        alertLabel.textColor = UIColor.white
    }
    
    func displayWrongAlert() {
        meaningContainer.backgroundColor = UIColor.wrong
        alertLabel.text = "Your answer is incorrect"
        alertLabel.textColor = UIColor.white
    }
    
    func displaySkipAlert() {
        meaningContainer.backgroundColor = UIColor.skip
        alertLabel.text = "Let's learn, remember!"
        alertLabel.textColor = UIColor.white
    }
    
    func displayCorrectVariant(index: Int) {
        let correctButton = variantButtonAtIndex(index)
        correctButton.backgroundColor = UIColor.correct
        correctButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    func displayWrongVariant(index: Int) {
        let wrongButton = variantButtonAtIndex(index)
        wrongButton.backgroundColor = UIColor.wrong
        wrongButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    func resetAlerts() {
        meaningContainer.backgroundColor = UIColor.blueBackground
        variant1Button.backgroundColor = UIColor.white
        variant2Button.backgroundColor = UIColor.white
        variant3Button.backgroundColor = UIColor.white
        variant4Button.backgroundColor = UIColor.white
        
        variant1Button.setTitleColor(UIColor.varianTextColor, for: .normal)
        variant2Button.setTitleColor(UIColor.varianTextColor, for: .normal)
        variant3Button.setTitleColor(UIColor.varianTextColor, for: .normal)
        variant4Button.setTitleColor(UIColor.varianTextColor, for: .normal)
    }
    
    func displayFinish() {
        finish()
    }
    
    // MARK: IBActions
    
    @IBAction func skipAction(_ button: UIButton) {
        interactor.skipMeaning()
    }
    
    @IBAction func checkVariant1(_ button: UIButton) {
        checkVariant(index: 0)
    }
    
    @IBAction func checkVariant2(_ button: UIButton) {
        checkVariant(index: 1)
    }
    
    @IBAction func checkVariant3(_ button: UIButton) {
        checkVariant(index: 2)
    }
    
    @IBAction func checkVariant4(_ button: UIButton) {
        checkVariant(index: 3)
    }
    
    @IBAction func listenAgain(_ button: UIButton) {
        interactor.listenAgain()
    }
    
    @IBAction func closeAction(_ button: UIButton) {
        finish()
    }
    
    
    // MARK: Utils
    
    func variantButtonAtIndex(_ index: Int) -> UIButton {
        switch index {
        case 0:
            return variant1Button
        case 1:
            return variant2Button
        case 2:
            return variant3Button
        default:
            return variant4Button
        }
    }
}
