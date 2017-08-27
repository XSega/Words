//
//  StartTrainingRouter.swift
//  Words
//
//  Created by Sergey Ilyushin on 30/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

@objc protocol IStartTrainingRouter {
    func routeToTraining()
}

protocol IStartTrainingDataPassing {
    var segueIdentifier: String! { get set }
}

class StartTrainingRouter: NSObject, IStartTrainingRouter, IStartTrainingDataPassing {
    weak var viewController: StartTrainingViewController!
    var dataStore: IStartTrainingDataStore!
    var segueIdentifier: String!
    
    // MARK: Routing
    
    func routeToTraining() {
        viewController.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    func routeToEngRuTraining(segue: UIStoryboardSegue) {
        if let destinationVC = segue.destination as? EngRuTrainingViewController, var destinationDS = destinationVC.router.dataStore {
            passDataToTraining(source: dataStore, destination: &destinationDS)
        }
    }
    
    func routeToRuEngTraining(segue: UIStoryboardSegue) {
        if let destinationVC = segue.destination as? RuEngTrainingViewController, var destinationDS = destinationVC.router.dataStore {
            passDataToTraining(source: dataStore, destination: &destinationDS)
        }
    }
    
    func routeToSprintTraining(segue: UIStoryboardSegue) {
        if let destinationVC = segue.destination as? SprintTrainingViewController, var destinationDS = destinationVC.router.dataStore {
            passDataToTraining(source: dataStore, destination: &destinationDS)
        }
    }
    
    func routeToListeningTraining(segue: UIStoryboardSegue) {
        if let destinationVC = segue.destination as? ListeningTrainingViewController, var destinationDS = destinationVC.router.dataStore {
            passDataToTraining(source: dataStore, destination: &destinationDS)
        }
    }
    
    // MARK: Passing data
    
    func passDataToTraining(source: IStartTrainingDataStore, destination: inout ITrainingDataStore)
    {
        destination.meanings = source.meanings
    }
}
