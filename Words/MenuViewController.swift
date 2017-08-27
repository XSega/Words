//
//  MenuViewController.swift
//  Words
//
//  Created by Sergey Ilyushin on 22/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet public var startButton: UIButton!
    
    // MARK: Public Vars
    public var api: API!
    public var ids = [Int]()
    
    public var meaningsController: MeaningsController!
    public let ruEngTraining = RuEngTrainingPresenter()
    public let engRuTraining = EngRuTrainingPresenter()
    public let listeningTraining = ListeningTrainingPresenter()
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    func startEngRuTraining() {
        
        meaningsController.requestAnyMeanings(count: 10, completionHandler: { [unowned self] (meanings) in
            
            let trainingController = self.storyboard!.instantiateViewController(withIdentifier: "EngRuViewController") as! EngRuViewController
            trainingController.presenter = self.engRuTraining
            
            self.engRuTraining.meanings = meanings
            self.engRuTraining.view = trainingController
            
            self.navigationController?.pushViewController(trainingController, animated: true)
        }) { (error) in
            
        }
    }
    
    func startRuEngTraining() {
        
        meaningsController.requestAnyMeanings(count: 10, completionHandler: { [unowned self] (meanings) in
            
            let trainingController = self.storyboard!.instantiateViewController(withIdentifier: "RuEngViewController") as! RuEngViewController
            trainingController.presenter = self.ruEngTraining
            
            self.ruEngTraining.meanings = meanings
            self.ruEngTraining.view = trainingController
            
            self.navigationController?.pushViewController(trainingController, animated: true)
        }) { (error) in
            
        }
    }
    
    func startListeningTraining() {
        
        meaningsController.requestAnyMeanings(count: 10, completionHandler: { [unowned self] (meanings) in
            DispatchQueue.main.async {
                let trainingController = self.storyboard!.instantiateViewController(withIdentifier: "ListeningViewController") as! ListeningViewController
                trainingController.presenter = self.listeningTraining
                
                self.listeningTraining.meanings = meanings
                self.listeningTraining.view = trainingController
                
                self.navigationController?.pushViewController(trainingController, animated: true)
            }
        }) { (error) in
            
        }
    }
    
    func startSprintTraining() {
        
//        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "SprintViewController") as! SprintViewController
//        let interactor = TrainingInteractor()
//        let presenter = SprintTrainingPresenter();
//        
//        viewController.presenter = presenter
//        presenter.view = viewController
//        presenter.interactor = interactor
//        interactor.presenter = presenter
//        
//        let apiDataManager = APIDataManager(api: api)
//        let localDataManager = LocalDataManager()
//        interactor.apiDataManager = apiDataManager
//        interactor.localDataManager = localDataManager
//        interactor.meaningIds = ids
        let viewController = TrainingRouter.assembleSprintModule(meaningIds: ids, api: api)
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    
    // MARK:- IBActions
    
    @IBAction func startRuEngAction(_ button: UIButton) {
        startRuEngTraining()
    }

    @IBAction func startEngRuAction(_ button: UIButton) {
       startEngRuTraining()
    }
    
    @IBAction func startSprintAction(_ button: UIButton) {
        startSprintTraining()
    }
    
    @IBAction func startListeningAction(_ button: UIButton) {
        startListeningTraining()
    }
    
    @IBAction func unwindFromSrpint(segue:UIStoryboardSegue)
    {
        
    }
}
