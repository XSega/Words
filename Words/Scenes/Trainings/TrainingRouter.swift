//
//  SprintTrainingRouter.swift
//  Words
//
//  Created by Sergey Ilyushin on 28/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

@objc protocol ITrainingRouter {
  
}

protocol ITrainingDataPassing {
    var dataStore: ITrainingDataStore! { get }
}

class TrainingRouter: NSObject, ITrainingRouter, ITrainingDataPassing {
    weak var viewController: TrainingViewController!
    var dataStore: ITrainingDataStore!
  
    // MARK: Routing

    func routeToFinishTraining(segue: UIStoryboardSegue) {
        if let destinationVC = segue.destination as? FinishTrainingViewController, var destinationDS = destinationVC.router!.dataStore {
            passDataToFinishTraining(source: dataStore, destination: &destinationDS)
        }
    }

    // MARK: Passing data

    func passDataToFinishTraining(source: ITrainingDataStore, destination: inout IFinishTrainingDataStore)
    {
        destination.mistakes = source.mistakes
        destination.words = source.words
        destination.learnedIdentifiers = source.learnedIdentifiers
    }
}
