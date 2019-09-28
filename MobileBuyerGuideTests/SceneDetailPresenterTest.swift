//
//  SceneDetailPresenterTest.swift
//  MobileBuyerGuideTests
//
//  Created by Phonthep Aungkanukulwit on 28/9/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import XCTest
@testable import MobileBuyerGuide
class SceneDetailPresenterTest: XCTestCase {
  var presenter: SceneDetailPresenter!
  
  func setUpSceneDetailPresenter() {
    presenter = SceneDetailPresenter()
  }
  
  // MARK: - MOCK PRESENTER
  class SceneDetailViewcontrollerSpy: SceneDetailViewControllerInterface {
    var displayGetImageCalled = false
    var displayGetDetailPhoneCelled = false
    
    func displayImage(viewModel: SceneDetail.GetImage.ViewModel) {
      displayGetImageCalled = true
    }
    
    func displayCollectionView(viewModel: SceneDetail.GetDetailPhone.ViewModel) {
      displayGetDetailPhoneCelled = true
    }
  }
  
  override func setUp() {
    super.setUp()
    setUpSceneDetailPresenter()
  }
  
  override func tearDown() {
    
  }
  
  // MARK: - TEST PRESENTER
  func testPresentGetImageShouldAskViewcontrollerToDisplayImage() {
    //Given
    let detailPhone: [DetailPhoneElement] = [DetailPhoneElement(id: 1, url: "http://", mobileID: 1)]
    let viewcontrollerSpy = SceneDetailViewcontrollerSpy()
    presenter.viewController = viewcontrollerSpy
    
    //When
    let response = SceneDetail.GetImage.Response(responseData: detailPhone)
    presenter.presentGetImage(response: response)
    
    //Then
    XCTAssert(viewcontrollerSpy.displayGetImageCalled, "presentGetImage() should ask viewcontroller to displayImage()")
  }
  
  func testPresentGetImageShouldAskViewcontrollerToDisplayImageWithFailure() {
    //Given
    let detailPhone: [DetailPhoneElement] = [DetailPhoneElement(id: 1, url: "www.phone", mobileID: 1)]
    let viewcontrollerSpy = SceneDetailViewcontrollerSpy()
    presenter.viewController = viewcontrollerSpy
    
    //When
    let response = SceneDetail.GetImage.Response(responseData: detailPhone)
    presenter.presentGetImage(response: response)
    
    //Then
    XCTAssert(viewcontrollerSpy.displayGetImageCalled, "presentGetImage() should ask viewcontroller to displayImage()")
  }
  
  func testPresentGetDetailPhoneShouldAskViewcontrollerToDisplayCollectionView() {
    //Given
    let mobileDataAtRow: PhoneElement = PhoneElement(brand: "phone", thumbImageURL: "thumbImageURL", phoneDescription: "phoneDescription", rating: 5.0, id: 1, price: 333, name: "phone")
    let viewcontrollerSpy = SceneDetailViewcontrollerSpy()
    presenter.viewController = viewcontrollerSpy
    
    //When
    let response = SceneDetail.GetDetailPhone.Response(mobileDataAtRow: mobileDataAtRow)
    presenter.presentGetDetailPhone(response: response)
    
    //Then
    XCTAssert(viewcontrollerSpy.displayGetDetailPhoneCelled, "presentCollectionView() should ask viewcontroller to displayCollectionView()")
  }
}
