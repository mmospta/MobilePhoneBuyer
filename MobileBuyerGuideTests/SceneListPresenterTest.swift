//
//  SceneListPresenterTest.swift
//  MobileBuyerGuideTests
//
//  Created by Phonthep Aungkanukulwit on 27/9/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import XCTest
@testable import MobileBuyerGuide
class SceneListPresenterTest: XCTestCase {
  var presenter: SceneListPresenter!
  
  func setUpSceneListPresenter() {
    presenter = SceneListPresenter()
  }
  
  // MARK: - MOCK VIEWCONTROLLER
  class SceneListViewcontrollerSpy: SceneListViewControllerInterface {
    var displayPhoneCalled = false
    var displayFavouriteIdCalled = false
    var displayTapSelectRowCalled = false
    
    func displayPhone(viewModel: SceneList.GetPhone.ViewModel) {
      displayPhoneCalled = true
    }
    
    func displayFavouriteId(viewModel: SceneList.TapFavourite.ViewModel) {
      displayFavouriteIdCalled = true
    }
    
    func displayTapSelectRow(viewModel: SceneList.TapSelectRow.ViewModel) {
      displayTapSelectRowCalled = true
    }
    
  }
  
  override func setUp() {
    super.setUp()
    setUpSceneListPresenter()
  }
  
  override func tearDown() {
  }
  
  // MARK: - TEST VIEWCONTROLLER
  func testPresenterPhoneShouldAskViewcontrollerToDisplayPhone() {
    //Given
    let responseData: [PhoneElement] = [PhoneElement(brand: "phone", thumbImageURL: "thumbImageURL", phoneDescription: "phoneDescription", rating: 5.0, id: 1, price: 333, name: "phone")]
    let viewcontrollerSpy = SceneListViewcontrollerSpy()
    presenter.viewController = viewcontrollerSpy
    
    //When
    let response = SceneList.GetPhone.Response(responseData: responseData, hiddenFavouriteButton: .hidden)
    presenter.presentPhone(response: response)
    
    //Then
    XCTAssert(viewcontrollerSpy.displayPhoneCalled, "presentPhone() should ask viewcontroller to displayPhone()")
  }
  
  func testPresentFavouriteIdShouldAskViewcontrollerToDisplayFavouriteId() {
    //Given
    let favouriteId: [Int] = [1, 2, 3]
    let viewcontrollerSpy = SceneListViewcontrollerSpy()
    presenter.viewController = viewcontrollerSpy
    
    //When
    let response = SceneList.TapFavourite.Response(favouriteId: favouriteId)
    presenter.presentFavouriteId(response: response)
    
    //Then
    XCTAssert(viewcontrollerSpy.displayFavouriteIdCalled, "presentFavouriteId() should ask viewcontroller to displayFavouriteId()")
  }
  
  func testPresenterTapSelectRowShouldAskViewcontrollerToDisplayTapSelectRow() {
    //Given
    let responseData: PhoneElement = PhoneElement(brand: "phone", thumbImageURL: "thumbImageURL", phoneDescription: "phoneDescription", rating: 5.0, id: 1, price: 333, name: "phone")
    let viewcontrollerSpy = SceneListViewcontrollerSpy()
    presenter.viewController = viewcontrollerSpy
    
    //When
    let response = SceneList.TapSelectRow.Response(responseData: responseData)
    presenter.presentTapSelectRow(response: response)
    
    //Then
    XCTAssert(viewcontrollerSpy.displayTapSelectRowCalled, "presentTapSelectRow() should ask viewcontroller to displayTapSelectRow()")
  }
}
