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
  func getSortingPriceLowToHigh(request: SceneList.GetPhone.Request)
  func getSortingPriceHighToLow(request: SceneList.GetPhone.Request)
  func getSortingRating(request: SceneList.GetPhone.Request)
  func tapSelectRow(request: SceneList.TapSelectRow.Request)
  var mobileId: Int {get set}
}

class SceneListInteractor: SceneListInteractorInterface {
  
  var presenter: SceneListPresenterInterface!
  var worker: SceneListWorker?
  var model: Entity?
  var responseData: Phone = []
  var mobileListDataFavourite: Phone = []
  var favouriteId: [Int] = []
  var favouriteData: Phone = []
  var hiddenButton: Bool = false
  var sortData: Phone = []
  var mobileId: Int = 0
  
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
      let response = SceneList.GetPhone.Response(responseData: self!.responseData, hiddenButton: self!.hiddenButton)
      self?.presenter.presentPhone(response: response)
    }
  }
  
  func getAllData(request: SceneList.GetPhone.Request) {
    hiddenButton = false
    let response = SceneList.GetPhone.Response(responseData: responseData, hiddenButton: hiddenButton)
    presenter.presentPhone(response: response)
  }
  
  func getFavouriteData(request: SceneList.GetPhone.Request) {
    favouriteData = responseData.filter { favouriteId.contains($0.id)}
    hiddenButton = true
    let response = SceneList.GetPhone.Response(responseData: favouriteData, hiddenButton: hiddenButton)
    presenter.presentPhone(response: response)
  }
  
  func getSortingPriceLowToHigh(request: SceneList.GetPhone.Request) {
    switch hiddenButton {
    case false:
      responseData.sort(by: {$0.price < $1.price})
      sortData = responseData
    case true:
      favouriteData.sort(by: {$0.price < $1.price})
      sortData = favouriteData
    default:
      break
    }
    
    let response = SceneList.GetPhone.Response(responseData: self.sortData, hiddenButton: self.hiddenButton)
    self.presenter.presentPhone(response: response)
  }
  
  
  
  func getSortingPriceHighToLow(request: SceneList.GetPhone.Request) {
    switch hiddenButton {
    case false:
      responseData.sort(by: {$0.price > $1.price})
      sortData = responseData
    case true:
      favouriteData.sort(by: {$0.price > $1.price})
      sortData = favouriteData
    default:
      break
    }
    
    let response = SceneList.GetPhone.Response(responseData: self.sortData, hiddenButton: self.hiddenButton)
    self.presenter.presentPhone(response: response)
    
  }
  
  func getSortingRating(request: SceneList.GetPhone.Request) {
    switch hiddenButton {
    case false:
      responseData.sort(by: {$0.rating > $1.rating})
      sortData = responseData
    case true:
      favouriteData.sort(by: {$0.rating > $1.rating})
      sortData = favouriteData
    default:
      break
    }
    
    let response = SceneList.GetPhone.Response(responseData: self.sortData, hiddenButton: self.hiddenButton)
    self.presenter.presentPhone(response: response)
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
  
  func tapSelectRow(request: SceneList.TapSelectRow.Request) {
    let response = SceneList.TapSelectRow.Response(mobileId: request.mobileId)
    mobileId = request.mobileId
    presenter.presentTapSelectRow(response: response)
  }
  
}
