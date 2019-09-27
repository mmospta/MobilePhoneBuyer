//
//  SceneListInteractorTest.swift
//  MobileBuyerGuideTests
//
//  Created by Phonthep Aungkanukulwit on 26/9/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import XCTest
@testable import MobileBuyerGuide
class SceneListInteractorTest: XCTestCase {
  var interactor: SceneListInteractor!
  var worker: SceneListWorker!
  
  func setUpSceneListInteractor() {
    interactor = SceneListInteractor()
  }
  
  // MARK: - MOCK PRESENTER
  class SceneListPresenterSpy:  SceneListPresenterInterface {
    var presentPhoneCalled = false
    var presentFavouriteIdCalled = false
    var presentTapSelectRowCalled = false
    
    func presentPhone(response: SceneList.GetPhone.Response) {
      presentPhoneCalled = true
    }
    
    func presentFavouriteId(response: SceneList.TapFavourite.Response) {
      presentFavouriteIdCalled = true
    }
    
    func presentTapSelectRow(response: SceneList.TapSelectRow.Response) {
      presentTapSelectRowCalled = true
    }
  }
  
  func mockPhoneElementData(id: Int) -> PhoneElement {
    
    if  id == 1 {
      return PhoneElement(brand: "phone", thumbImageURL: "thumbImageURL", phoneDescription: "phoneDescription", rating: 5.0, id: 1, price: 333, name: "phone")
    }else if id == 2 {
      return PhoneElement(brand: "phone", thumbImageURL: "thumbImageURL", phoneDescription: "phoneDescription", rating: 2.2, id: 2, price: 455, name: "phone")
    }else{
      return PhoneElement(brand: "phone", thumbImageURL: "thumbImageURL", phoneDescription: "phoneDescription", rating: 4, id: 3, price: 122, name: "phone")
    }
  }
  
  override func setUp() {
    super.setUp()
    setUpSceneListInteractor()
  }
  
  override func tearDown() {
  }
  
  // MARK: - TEST INTERACTOR
  
  class SceneListStoreSpy: SceneListStore {
    var forceFailure = false
    override func getData(_ completion: @escaping (Result<[PhoneElement], APIError>) -> Void) {
      if forceFailure {
        completion(.failure(APIError.invalidJSON))
      } else {
        let mockData: [PhoneElement] = [SceneListInteractorTest().mockPhoneElementData(id: 1)]
        completion(.success(mockData))
      }
    }
  }
  
  func testGetPhoneShouldAskPresenterToPresentPhone() {
    //Given
    let mockStore = SceneListStoreSpy()
    let presenterSpy = SceneListPresenterSpy()
    interactor.presenter = presenterSpy
    interactor.worker = SceneListWorker(store: mockStore)
    
    //When
    let request = SceneList.GetPhone.Request(state: .all)
    interactor.getPhone(request: request)
    
    //Then
    XCTAssert(presenterSpy.presentPhoneCalled, "getPhone() should ask presenter to presentPhone()")
  }
  
  func testGetPhoneShouldAskPresenterToPresentPhoneWithFailure() {
    //Given
    let mockStore = SceneListStoreSpy()
    let presenterSpy = SceneListPresenterSpy()
    interactor.presenter = presenterSpy
    interactor.worker = SceneListWorker(store: mockStore)
    
    //When
    mockStore.forceFailure = true
    let request = SceneList.GetPhone.Request(state: .all)
    interactor.getPhone(request: request)
    
    //Then
    XCTAssert(presenterSpy.presentPhoneCalled, "getPhone() should ask presenter to presentPhone() with Failurue")
  }
  
  func testGetAllDataShouldAskPresenterToPresentPhone() {
    //Given
    let presenterSpy = SceneListPresenterSpy()
    interactor.presenter = presenterSpy
    
    //When
    let request = SceneList.GetPhone.Request(state: .all)
    interactor.getAllData(request: request)
    
    //Then
    XCTAssert(presenterSpy.presentPhoneCalled, "getAllData() should ask presenter to presentPhone()")
  }
  
  func testGetFavouriteDataShouldAskPresenterToPresentPhone() {
    //Given
    let responseData: [PhoneElement] = [mockPhoneElementData(id: 1), mockPhoneElementData(id: 2), mockPhoneElementData(id: 3)]
    let favouriteId: [Int] = [1 ,2 ,3]
    let presenterSpy = SceneListPresenterSpy()
    interactor.presenter = presenterSpy
    interactor.favouriteId = favouriteId
    interactor.responseData = responseData
    
    //When
    let request = SceneList.GetPhone.Request(state: .favourite)
    interactor.getFavouriteData(request: request)
    
    //Then
    XCTAssert(presenterSpy.presentPhoneCalled, "getFavouriteData() should ask presenter to presentPhone()")
  }
  
  func testSortingPriceLowToHighAll() {
    //Given
    let sortingType: SortType = .priceLowToHigh
    interactor.segmentControllState = .all
    interactor.responseData = [mockPhoneElementData(id: 1), mockPhoneElementData(id: 2), mockPhoneElementData(id: 3)]
    let expectedPhoneElement = [mockPhoneElementData(id: 3), mockPhoneElementData(id: 1), mockPhoneElementData(id: 2)]
    
    //When
    let actualPhoneElement = interactor.sorting(sortType: sortingType)
    
    //Then
    XCTAssertEqual(expectedPhoneElement[0].price, actualPhoneElement[0].price)
    XCTAssertEqual(expectedPhoneElement[1].price, actualPhoneElement[1].price)
    XCTAssertEqual(expectedPhoneElement[2].price, actualPhoneElement[2].price)
  }
  
  func testSortingPriceHighToLowAll() {
    //Given
    let sortingType: SortType = .priceHighToLow
    interactor.segmentControllState = .all
    interactor.responseData = [mockPhoneElementData(id: 1), mockPhoneElementData(id: 2), mockPhoneElementData(id: 3)]
    let expectedPhoneElement = [mockPhoneElementData(id: 2), mockPhoneElementData(id: 1), mockPhoneElementData(id: 3)]
    
    //When
    let actualPhoneElement = interactor.sorting(sortType: sortingType)
    
    //Then
    XCTAssertEqual(expectedPhoneElement[0].price, actualPhoneElement[0].price)
    XCTAssertEqual(expectedPhoneElement[1].price, actualPhoneElement[1].price)
    XCTAssertEqual(expectedPhoneElement[2].price, actualPhoneElement[2].price)
  }
  
  func testSortingRatingHighToLowAll() {
    //Given
    let sortingType: SortType = .ratingHighToLow
    interactor.segmentControllState = .all
    interactor.responseData = [mockPhoneElementData(id: 1), mockPhoneElementData(id: 2), mockPhoneElementData(id: 3)]
    let expectedPhoneElement = [mockPhoneElementData(id: 1), mockPhoneElementData(id: 3), mockPhoneElementData(id: 2)]
    
    //When
    let actualPhoneElement = interactor.sorting(sortType: sortingType)
    
    //Then
    XCTAssertEqual(expectedPhoneElement[0].rating, actualPhoneElement[0].rating)
    XCTAssertEqual(expectedPhoneElement[1].rating, actualPhoneElement[1].rating)
    XCTAssertEqual(expectedPhoneElement[2].rating, actualPhoneElement[2].rating)
  }
  
  func testSortingPriceLowToHighFavourite() {
    //Given
    let sortingType: SortType = .priceLowToHigh
    interactor.segmentControllState = .favourite
    interactor.favouriteData = [mockPhoneElementData(id: 1), mockPhoneElementData(id: 2), mockPhoneElementData(id: 3)]
    let expectedPhoneElement = [mockPhoneElementData(id: 3), mockPhoneElementData(id: 1), mockPhoneElementData(id: 2)]
    
    //When
    let actualPhoneElement = interactor.sorting(sortType: sortingType)
    
    //Then
    XCTAssertEqual(expectedPhoneElement[0].price, actualPhoneElement[0].price)
    XCTAssertEqual(expectedPhoneElement[1].price, actualPhoneElement[1].price)
    XCTAssertEqual(expectedPhoneElement[2].price, actualPhoneElement[2].price)
  }
  
  func testSortingPriceHighToLowFavourite() {
    //Given
    let sortingType: SortType = .priceHighToLow
    interactor.segmentControllState = .favourite
    interactor.favouriteData = [mockPhoneElementData(id: 1), mockPhoneElementData(id: 2), mockPhoneElementData(id: 3)]
    let expectedPhoneElement = [mockPhoneElementData(id: 2), mockPhoneElementData(id: 1), mockPhoneElementData(id: 3)]
    
    //When
    let actualPhoneElement = interactor.sorting(sortType: sortingType)
    
    //Then
    XCTAssertEqual(expectedPhoneElement[0].price, actualPhoneElement[0].price)
    XCTAssertEqual(expectedPhoneElement[1].price, actualPhoneElement[1].price)
    XCTAssertEqual(expectedPhoneElement[2].price, actualPhoneElement[2].price)
  }
  
  func testSortingRatingHighToLowFavourite() {
    //Given
    let sortingType: SortType = .ratingHighToLow
    interactor.segmentControllState = .favourite
    interactor.favouriteData = [mockPhoneElementData(id: 1), mockPhoneElementData(id: 2), mockPhoneElementData(id: 3)]
    let expectedPhoneElement = [mockPhoneElementData(id: 1), mockPhoneElementData(id: 3), mockPhoneElementData(id: 2)]
    
    //When
    let actualPhoneElement = interactor.sorting(sortType: sortingType)
    
    //Then
    XCTAssertEqual(expectedPhoneElement[0].rating, actualPhoneElement[0].rating)
    XCTAssertEqual(expectedPhoneElement[1].rating, actualPhoneElement[1].rating)
    XCTAssertEqual(expectedPhoneElement[2].rating, actualPhoneElement[2].rating)
  }
  
  func testGetSortPhoneShouldAskPresenterToPresentPhone() {
    //Given
    let presenterSpy = SceneListPresenterSpy()
    interactor.presenter = presenterSpy
    
    //When
    let request = SceneList.SortPhone.Request(sortType: .none)
    interactor.getSortPhone(request: request)
    
    //Then
    XCTAssert(presenterSpy.presentPhoneCalled, "getSortPhone() should ask presenter to presentPhone()")
  }
  
  func testSetFavouritePhoneShouldAskPresenterToPresentFavouriteId() {
    //Given
    let id: Int = 1
    let favouriteId: [Int] = [2,3,1,4,5]
    let presenterSpy = SceneListPresenterSpy()
    interactor.presenter = presenterSpy
    interactor.favouriteId = favouriteId
    
    //When
    let request = SceneList.TapFavourite.Request(favouriteId: id)
    interactor.setFavouritePhone(request: request)
    
    //Then
    XCTAssert(presenterSpy.presentFavouriteIdCalled, "getFavouritePhone() should ask presenter to presentFavouriteId()")
  }
  
  func testSetFavouritePhoneShouldAskPresenterToPresentFavouriteIdWithFalse() {
    //Given
    let id: Int = 1
    let presenterSpy = SceneListPresenterSpy()
    interactor.presenter = presenterSpy
    
    //When
    let request = SceneList.TapFavourite.Request(favouriteId: id)
    interactor.setFavouritePhone(request: request)
    
    //Then
    XCTAssert(presenterSpy.presentFavouriteIdCalled, "getFavouritePhone() should ask presenter to presentFavouriteId() with false")
  }
  
  func testTapSelectRowAskPresenterToPresentTapSelectRowCalled() {
    //Given
    let responseData: PhoneElement = mockPhoneElementData(id: 1)
    let presenterSpy = SceneListPresenterSpy()
    interactor.presenter = presenterSpy
    
    //When
    let request = SceneList.TapSelectRow.Request(responseData: responseData)
    interactor.tapSelectRow(request: request)
    
    //Then
    XCTAssert(presenterSpy.presentTapSelectRowCalled)
  }
}
