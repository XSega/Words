//
//  ListeningTrainingViewController.swift
//  Words
//
//  Created by Sergey Ilyushin on 30/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IListeningTrainingView: class
{
    func display()
    func display(text: String, translation: String, imageData: Data?)
    func displayCorrectAlert()
    func displayWrongAlert(text: String)
    func displaySkipAlert()
    func displayFinish()
}

class ListeningTrainingViewController: TrainingViewController, IListeningTrainingView
{
    // MARK: Outlets
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var wrongTextLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var speakerContainer: UIView!
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var skippedButton: UIButton!
    
    @IBOutlet weak var textContainer: UIView!
    @IBOutlet weak var meaningContainer: UIView!
    @IBOutlet weak var wrongContainer: UIView!
    
    @IBOutlet weak var keyboardHeightConstraint: NSLayoutConstraint!
    
    // MARK: Scene Vars
    
    var interactor: IListeningTrainingInteractor!
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
        let interactor = ListeningTrainingInteractor()
        let presenter = ListeningTrainingPresenter()
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    func start() {
        interactor?.start()
        
        self.textField.becomeFirstResponder()
    }
    
    func skip() {
        interactor?.skipMeaning()
    }
    
    func finish() {
        performSegue(withIdentifier: "FinishTraining", sender: self)
    }
    
    fileprivate func showCheckButton() {
        checkButton.isHidden = false
        wrongContainer.isHidden = true
        correctButton.isHidden = true
        skippedButton.isHidden = true
    }
    
    fileprivate func showWrongButton() {
        checkButton.isHidden = true
        wrongContainer.isHidden = false
        correctButton.isHidden = true
        skippedButton.isHidden = true
    }
    
    fileprivate func showCorrectButton() {
        checkButton.isHidden = true
        wrongContainer.isHidden = true
        correctButton.isHidden = false
        skippedButton.isHidden = true
    }
    
    fileprivate func showSkippedButton() {
        checkButton.isHidden = true
        wrongContainer.isHidden = true
        correctButton.isHidden = true
        skippedButton.isHidden = false
    }
    
    // MARK: IBActions
    
    @IBAction func checkAction(_ button: UIButton) {
        interactor.checkTranslation(text: textField.text)
    }
    
    @IBAction func nextAction(_ button: UIButton) {
        skip()
    }
    
    @IBAction func closeAction(_ button: UIButton) {
        finish()
    }
    
    // MARK: IListeningView
    
    func display() {
        textContainer.isHidden = false
        meaningContainer.isHidden = true
        
        speakerContainer.isHidden = false
        imageView.isHidden = true
        
        textField.text = nil
        
        showCheckButton()
    }
    
    func display(text: String, translation: String, imageData: Data?) {
        textContainer.isHidden = true
        meaningContainer.isHidden = false
        
        speakerContainer.isHidden = true
        imageView.isHidden = false
        
        textLabel.text = text
        translationLabel.text = translation
        
        if let imageData = imageData {
            imageView.image = UIImage(data: imageData)
        }
    }
    
    func displayCorrectAlert() {
        showCorrectButton()
    }
    
    func displayWrongAlert(text: String){
        wrongTextLabel.text = text
        showWrongButton()
    }
    
    func displaySkipAlert() {
        showSkippedButton()
    }
    
    func displayFinish() {
        finish()
    }
    
    // MARK: Keyboard change observer
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardFrame.size.height
            keyboardHeightConstraint.constant = keyboardHeight
        }
    }
}
