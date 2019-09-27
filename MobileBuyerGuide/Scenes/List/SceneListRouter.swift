//
//  SceneListRouter.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol SceneListRouterInput {
  func navigateToSomewhere()
}

class SceneListRouter: SceneListRouterInput {
  weak var viewController: SceneListViewController!
  
  // MARK: - Navigation
  
  func navigateToSomewhere() {
    viewController.performSegue(withIdentifier: "DetailPhone", sender: nil)
  }
  
  // MARK: - Communication
  
  func passDataToNextScene(segue: UIStoryboardSegue) {
    if segue.identifier == "DetailPhone" {
      passDataToSomewhereScene(segue: segue)
    }
  }
  
  func passDataToSomewhereScene(segue: UIStoryboardSegue) {
    let someWhereViewController = segue.destination as! SceneDetailViewController
    someWhereViewController.interactor.mobileDataAtRow = viewController.interactor.mobileDataAtRow
  }
}
