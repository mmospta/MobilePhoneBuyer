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
  func setFavouritePhone(request: SceneList.TapFavourite.Request)
  func getAllData(request: SceneList.GetPhone.Request)
  func getFavouriteData(request: SceneList.GetPhone.Request)
  func getSortPhone(request: SceneList.SortPhone.Request)
  func tapSelectRow(request: SceneList.TapSelectRow.Request)
  var mobileDataAtRow: PhoneElement? {get set}
}

class SceneListInteractor: SceneListInteractorInterface {
  
  var presenter: SceneListPresenterInterface!
  var worker: SceneListWorker?
  var responseData: [PhoneElement] = []
  var mobileListDataFavourite: [PhoneElement] = []
  var favouriteId: [Int] = []
  var favouriteData: [PhoneElement] = []
  var segmentControllState: SegmentControlState = .all
  var sortData: [PhoneElement] = []
  var mobileDataAtRow: PhoneElement?
  
  // MARK: - Business logic
  
  func getPhone(request: SceneList.GetPhone.Request) {
    worker?.getPhone { [weak self] apiResponse in
      switch apiResponse {
      case .success(let data):
        self!.responseData = data
      case .failure(let error):
        print(error)
        
      }
      
      let response = SceneList.GetPhone.Response(responseData: self!.responseData)
      self?.presenter.presentPhone(response: response)
      
    }
  }
  
  func getAllData(request: SceneList.GetPhone.Request) {
    segmentControllState = .all
    let response = SceneList.GetPhone.Response(responseData: responseData)
    presenter.presentPhone(response: response)
  }
  
  func getFavouriteData(request: SceneList.GetPhone.Request) {
    favouriteData = responseData.filter { favouriteId.contains($0.id)}
    segmentControllState = .favourite
    let response = SceneList.GetPhone.Response(responseData: favouriteData)
    presenter.presentPhone(response: response)
  }
  
  
  
  func sorting(sortType: SortType) -> [PhoneElement] {
    var phoneList: [PhoneElement] = []
    
    if segmentControllState == .all {
      phoneList = responseData
    }else{
      phoneList = favouriteData
    }
    
    switch sortType {
    case .priceLowToHigh:
      print("low to high")
      phoneList.sort(by: {$0.price < $1.price})
    case .priceHighToLow:
      print("high")
      phoneList.sort(by: {$0.price > $1.price})
    case .ratingHighToLow:
      print("rating")
      phoneList.sort(by: {$0.rating > $1.rating})
    case .none:
      break
    }
    return phoneList
  }
  
  func getSortPhone(request: SceneList.SortPhone.Request) {
    let response = SceneList.GetPhone.Response(responseData: sorting(sortType: request.sortType))
    self.presenter.presentPhone(response: response)
  }
  
  func setFavouritePhone(request: SceneList.TapFavourite.Request) {
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
    let response = SceneList.TapSelectRow.Response(responseData: request.responseData)
    mobileDataAtRow = request.responseData
    presenter.presentTapSelectRow(response: response)
  }
}
