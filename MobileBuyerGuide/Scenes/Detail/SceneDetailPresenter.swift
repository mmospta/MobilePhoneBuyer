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
  func presentGetDetailPhone(response: SceneDetail.GetDetailPhone.Response)
}

class SceneDetailPresenter: SceneDetailPresenterInterface {
  weak var viewController: SceneDetailViewControllerInterface!
  var data: DetailPhoneElement = DetailPhoneElement(id: 0, url: "", mobileID: 0)
  var url: [String] = []
  
  // MARK: - Presentation logic
  
  func presentSomething(response: SceneDetail.Something.Response) {
    
    url  = response.responseData.map({
      if $0.url.hasPrefix("http://") || $0.url.hasPrefix("https://"){
        return $0.url
      }else{
        let correctURL = "http://\($0.url)"
        return correctURL
      }})
    
    let viewModel = SceneDetail.Something.ViewModel(url: url)
    viewController.displaySomething(viewModel: viewModel)
  } 
  
  func presentGetDetailPhone(response: SceneDetail.GetDetailPhone.Response) {
    let price: Double = response.mobileDataAtRow.price
    let rating: Double = response.mobileDataAtRow.rating
    let description: String = response.mobileDataAtRow.phoneDescription
    
    let viewModel = SceneDetail.GetDetailPhone.ViewModel(price: price, rating: rating, description: description)
    viewController.displayCollectionView(viewModel: viewModel)
  }
}
