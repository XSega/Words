//
//  TrainingRouter.swift
//  Words
//
//  Created by Sergey Ilyushin on 27/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

protocol ITrainingRouter: class {
    weak var viewController: UIViewController? { get set }
    
    func presentFinishScreen(mistakes: Int, words: Int)
    
    static func assembleSprintModule(meaningIds: [Int], api: API) -> UIViewController
}


class TrainingRouter: ITrainingRouter {

    weak var viewController: UIViewController?
    
    static func assembleSprintModule(meaningIds: [Int], api: API) -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "SprintViewController") as! SprintViewController
        let interactor = TrainingInteractor()
        let presenter = SprintTrainingPresenter();
        let router = TrainingRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        let apiDataManager = APIDataManager(api: api)
        let localDataManager = LocalDataManager()
        interactor.apiDataManager = apiDataManager
        interactor.localDataManager = localDataManager
        interactor.meaningIds = meaningIds
        
        view.presenter = presenter

        router.viewController = view
        
        return view
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func presentFinishScreen(mistakes: Int, words: Int) {
        let finishView = FinishTrainingRouter.assembleModule(mistakes: mistakes, words: words)
        viewController?.navigationController?.pushViewController(finishView, animated: true)
    }
}
