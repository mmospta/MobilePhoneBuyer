//
//  SceneDetailInteractor.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol SceneDetailInteractorInterface {
  func getImage(request: SceneDetail.GetImage.Request)
  func getDetailPhone(request: SceneDetail.GetDetailPhone.Request)
  var mobileDataAtRow: PhoneElement? { get set }
}

class SceneDetailInteractor: SceneDetailInteractorInterface {
  var presenter: SceneDetailPresenterInterface!
  var worker: SceneDetailWorker?
  var mobileDataAtRow: PhoneElement?
  var responseData: [DetailPhoneElement] = []
  
  // MARK: - Business logic
  
  func getImage(request: SceneDetail.GetImage.Request) {
    worker?.doSomeWork(mobileId: mobileDataAtRow!.id) { [weak self] apiResponse in
      switch apiResponse {
      case .success(let data):
        self!.responseData = data
      case .failure(let error):
        print(error)
      }
      let response = SceneDetail.GetImage.Response(responseData: self!.responseData)
      self!.presenter.presentGetImage(response: response)
    }
  }
  
  func getDetailPhone(request: SceneDetail.GetDetailPhone.Request) {
    let response = SceneDetail.GetDetailPhone.Response(mobileDataAtRow: mobileDataAtRow!)
    presenter.presentGetDetailPhone(response: response)
  }
}
