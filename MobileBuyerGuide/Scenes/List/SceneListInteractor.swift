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
  func getAllData(request: SceneList.GetPhone.Request)
  func getFavouriteData(request: SceneList.GetPhone.Request)
}

class SceneListInteractor: SceneListInteractorInterface {
  
  var presenter: SceneListPresenterInterface!
  var worker: SceneListWorker?
  var model: Entity?
  var responseData: Phone = []
  var mobileListDataFavourite: Phone = []
  var favouriteId: [Int] = []
  var mockData: Phone = [PhoneElement(brand: "xiaomi", thumbImageURL: "", phoneDescription: "helllllllo", rating: 5.5, id: 1, price: 111, name: "assscascas")]
  var favouriteData: Phone = []
  
  // MARK: - Business logic
  
  func getPhone(request: SceneList.GetPhone.Request) {
    worker?.getPhone { [weak self] in
      if case let Result.success(data) = $0 {
        switch Result.success(data){
        case .success(let data):
          self!.responseData = data
        case .failure:
          break
        }
      }
      let response = SceneList.GetPhone.Response(responseData: self!.responseData)
      self?.presenter.presentPhone(response: response)
    }
  }
  
  func getAllData(request: SceneList.GetPhone.Request) {
    let response = SceneList.GetPhone.Response(responseData: responseData)
    presenter.presentPhone(response: response)
  }
  
  func getFavouriteData(request: SceneList.GetPhone.Request) {
    let favouriteData = responseData.filter { favouriteId.contains($0.id)}
    print(favouriteData)
    
    let response = SceneList.GetPhone.Response(responseData: favouriteData)
    presenter.presentPhone(response: response)
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

