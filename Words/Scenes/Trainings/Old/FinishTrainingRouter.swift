//
//  FinishTrainingRouter.swift
//  Words
//
//  Created by Sergey Ilyushin on 27/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol IFinishTrainingRouter: class {
    
    weak var viewController: UIViewController? { get set }
    
    static func assembleModule(mistakes: Int, words: Int) -> UIViewController
    
    func finishTraining()
    func restartTraining()
}

class FinishTrainingRouter: IFinishTrainingRouter {
   
    weak var viewController: UIViewController?
    
    static func assembleModule(mistakes: Int, words: Int) -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "FinishTrainingViewController") as! FinishTrainingViewController
        let presenter = FinishTrainingPresenter()
        let router = FinishTrainingRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.mistakes = mistakes
        presenter.words = words
        presenter.router = router
        
        router.viewController = view
        
        return view
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func finishTraining() {
        //viewController?.navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    
    func restartTraining() {
        
    }
}
