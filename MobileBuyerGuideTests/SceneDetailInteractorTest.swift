//
//  SceneDetailInteractorTest.swift
//  MobileBuyerGuideTests
//
//  Created by Phonthep Aungkanukulwit on 28/9/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import XCTest
@testable import MobileBuyerGuide
class SceneDetailInteractorTest: XCTestCase {
  var interactor: SceneDetailInteractor!
  
  func setUpSceneDetailInteractor() {
    interactor = SceneDetailInteractor()
  }
  
  // MARK: - MOCK INTERACTOR
  class SceneDetailPresenterSpy: SceneDetailPresenterInterface {
    var presentGetImageCalled = false
    var presentGetDetailPhoneCalled = false
    
    func presentGetImage(response: SceneDetail.GetImage.Response) {
      presentGetImageCalled = true
    }
    
    func presentGetDetailPhone(response: SceneDetail.GetDetailPhone.Response) {
      presentGetDetailPhoneCalled = true
    }
  }
  
  override func setUp() {
    super.setUp()
    setUpSceneDetailInteractor()
  }
  
  override func tearDown() {
  }
  
  // MARK: - TEST INTERACTOR
  class SceneDetailStoreSpy: SceneDetailStore {
    var forceFailure = false
    override func getData(mobileId: Int, _ completion: @escaping (Result<[DetailPhoneElement], APIError>) -> Void) {
      if forceFailure {
        completion(.failure(APIError.invalidJSON))
      }else{
        let mockData: [DetailPhoneElement] = [DetailPhoneElement(id: 1, url: "http://", mobileID: 1)]
        completion(.success(mockData))
      }
    }
  }
  
  func testGetImageShouldAskPresenterToPresentGetImage() {
    //Given
    let mobileDataAtRow: PhoneElement = PhoneElement(brand: "phone", thumbImageURL: "thumbImageURL", phoneDescription: "phoneDescription", rating: 5.0, id: 1, price: 333, name: "phone")
    let mockStore = SceneDetailStoreSpy()
    let presenterSpy = SceneDetailPresenterSpy()
    interactor.presenter = presenterSpy
    interactor.worker = SceneDetailWorker(store: mockStore)
    interactor.mobileDataAtRow = mobileDataAtRow
    
    //When
    let request = SceneDetail.GetImage.Request()
    interactor.getImage(request: request)
    
    //Then
    XCTAssert(presenterSpy.presentGetImageCalled, "getImage() should ask presenter to presentImage()")
  }
  
  func testGetImageShouldAskPresenterToPresentGetImageWithFailure() {
    //Given
    let mobileDataAtRow: PhoneElement = PhoneElement(brand: "phone", thumbImageURL: "thumbImageURL", phoneDescription: "phoneDescription", rating: 5.0, id: 1, price: 333, name: "phone")
    let mockStore = SceneDetailStoreSpy()
    let presenterSpy = SceneDetailPresenterSpy()
    interactor.presenter = presenterSpy
    interactor.worker = SceneDetailWorker(store: mockStore)
    interactor.mobileDataAtRow = mobileDataAtRow
    
    //When
    mockStore.forceFailure = true
    let request = SceneDetail.GetImage.Request()
    interactor.getImage(request: request)
    
    //Then
    XCTAssert(presenterSpy.presentGetImageCalled, "getImage() should ask presenter to presentImage()")
  }

  func testGetDetailPhoneShouldAskPresenterToPresentGetDetailPhone() {
    //Given
    let mobileDataAtRow: PhoneElement = PhoneElement(brand: "phone", thumbImageURL: "thumbImageURL", phoneDescription: "phoneDescription", rating: 5.0, id: 1, price: 333, name: "phone")
    let presenterSpy = SceneDetailPresenterSpy()
    interactor.presenter = presenterSpy
    interactor.mobileDataAtRow = mobileDataAtRow
    
    //When
    let request = SceneDetail.GetDetailPhone.Request()
    interactor.getDetailPhone(request: request)
    
    //Then
    XCTAssert(presenterSpy.presentGetDetailPhoneCalled, "getDetailPhone() should ask presenter to presentDetialPhone()")
  }
}
