//
//  SceneDetailWorker.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol SceneDetailStoreProtocol {
  func getData(mobileId: Int, _ completion: @escaping (Result<DetailPhone, APIError>) -> Void)
}

class SceneDetailWorker {
  
  var store: SceneDetailStoreProtocol
  
  init(store: SceneDetailStoreProtocol) {
    self.store = store
  }
  
  // MARK: - Business Logic
  
  func doSomeWork(mobileId: Int, _ completion: @escaping (Result<DetailPhone, APIError>) -> Void) {
    store.getData(mobileId: mobileId) {
      completion($0)
    }
  }
}
