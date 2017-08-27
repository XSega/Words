//
//  FinishTrainingRouter.swift
//  Words
//
//  Created by Sergey Ilyushin on 29/07/2017.
//  Copyright (c) 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit

@objc protocol IFinishTrainingRouter {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol IFinishTrainingDataPassing {
    var dataStore: IFinishTrainingDataStore! { get }
}

class FinishTrainingRouter: NSObject, IFinishTrainingRouter, IFinishTrainingDataPassing {
    weak var viewController: FinishTrainingViewController!
    var dataStore: IFinishTrainingDataStore!
  
    // MARK: Routing

    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    //func navigateToSomewhere(source: FinishTrainingViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: IFinishTrainingDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
