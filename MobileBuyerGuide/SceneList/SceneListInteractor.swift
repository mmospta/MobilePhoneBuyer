//
//  SceneListInteractor.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol SceneListInteractorInterface {
  func getPhone(request: SceneList.GetPhone.Request)
  func favouriteButtonTapped(request: SceneList.TapFavourite.Request)
}

class SceneListInteractor: SceneListInteractorInterface {
  
  var presenter: SceneListPresenterInterface!
  var worker: SceneListWorker?
  var model: Entity?
  var responseData: Phone = []
  var mobileListDataFavourite: Phone = []
  var favouriteId: [Int] = []
  
  
  
  // MARK: - Business logic
  
  func getPhone(request: SceneList.GetPhone.Request) {
    worker?.doSomeWork { [weak self] in
      if case let Result.success(data) = $0 {
        switch Result.success(data){
        case .success(let data):
          self!.responseData = data
        case .failure:
          break
        }
        
        // If the result was successful, we keep the data so that we can deliver it to another view controller through the router.
        
      }
      
      // NOTE: Pass the result to the Presenter. This is done by creating a response model with the result from the worker. The response could contain a type like UserResult enum (as declared in the SCB Easy project) with the result as an associated value.
      let response = SceneList.GetPhone.Response(responseData: self!.responseData)
      self?.presenter.presentPhone(response: response)
    }
  }
  
  func favouriteButtonTapped(request: SceneList.TapFavourite.Request) {
    let id: Int = request.favouriteId
    if let index = favouriteId.firstIndex(where: {$0 == id}) {
      favouriteId.remove(at: index)
    }else{
      favouriteId.append(id)
    }
    let response = SceneList.TapFavourite.Response(favouriteId: favouriteId)
    presenter.presentFavouriteId(response: response)
  }
  
  
}

