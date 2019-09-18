//
//  SceneListPresenter.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol SceneListPresenterInterface {
  func presentSomething(response: SceneList.GetPhone.Response)
}

class SceneListPresenter: SceneListPresenterInterface {
  weak var viewController: SceneListViewControllerInterface!

  // MARK: - Presentation logic

  func presentSomething(response: SceneList.GetPhone.Response) {
    let viewModel = SceneList.GetPhone.ViewModel(passData: response.responseData)
    viewController.displaySomething(viewModel: viewModel)
  }
}
