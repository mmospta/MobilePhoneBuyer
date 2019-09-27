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
  
  class SceneListViewcontrollerSpy: SceneListViewController {
    
    
  }

    override func setUp() {
      super.setUp()
      setUpSceneListPresenter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
  
  

}
