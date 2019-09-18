//
//  SceneListInteractor.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol SceneListInteractorInterface {
  func doSomething(request: SceneList.GetPhone.Request)
  
}

class SceneListInteractor: SceneListInteractorInterface {
  var presenter: SceneListPresenterInterface!
  var worker: SceneListWorker?
  var model: Entity?
  
  // MARK: - Business logic
  
  func doSomething(request: SceneList.GetPhone.Request) {
    var responseData: Phone = []
    worker?.doSomeWork { [weak self] in
      if case let Result.success(data) = $0 {
        switch Result.success(data){
        case .success(let data):
          responseData = data
        case .failure:
          break
        }
        
        // If the result was successful, we keep the data so that we can deliver it to another view controller through the router.
        
      }
      
      // NOTE: Pass the result to the Presenter. This is done by creating a response model with the result from the worker. The response could contain a type like UserResult enum (as declared in the SCB Easy project) with the result as an associated value.
      let response = SceneList.GetPhone.Response(responseData: responseData)
      self?.presenter.presentSomething(response: response)
    }
  }
}
