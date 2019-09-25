//
//  SceneListPresenter.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol SceneListPresenterInterface {
  func presentPhone(response: SceneList.GetPhone.Response)
  func presentFavouriteId(response: SceneList.TapFavourite.Response)
  func presentTapSelectRow(response: SceneList.TapSelectRow.Response)
  
}

class SceneListPresenter: SceneListPresenterInterface {
  
  weak var viewController: SceneListViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentPhone(response: SceneList.GetPhone.Response) {
    let viewModel = SceneList.GetPhone.ViewModel(passData: response.responseData)
    viewController.displayPhone(viewModel: viewModel)
  }
  
  func presentFavouriteId(response: SceneList.TapFavourite.Response) {
    let viewModel = SceneList.TapFavourite.ViewModel(favouriteId: response.favouriteId)
    viewController.displayFavouriteId(viewModel: viewModel)
  }
  
  func presentTapSelectRow(response: SceneList.TapSelectRow.Response) {
    let viewModel = SceneList.TapSelectRow.ViewModel()
    viewController.displayTapSelectRow(viewModel: viewModel)
  }
  
}
