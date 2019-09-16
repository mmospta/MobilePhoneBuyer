//
//  SceneDetailPresenter.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol SceneDetailPresenterInterface {
  func presentSomething(response: SceneDetail.Something.Response)
}

class SceneDetailPresenter: SceneDetailPresenterInterface {
  weak var viewController: SceneDetailViewControllerInterface!

  // MARK: - Presentation logic

  func presentSomething(response: SceneDetail.Something.Response) {
    // NOTE: Format the response from the Interactor and pass the result back to the View Controller. The resulting view model should be using only primitive types. Eg: the view should not need to involve converting date object into a formatted string. The formatting is done here.

    let viewModel = SceneDetail.Something.ViewModel()
    viewController.displaySomething(viewModel: viewModel)
  }
}
