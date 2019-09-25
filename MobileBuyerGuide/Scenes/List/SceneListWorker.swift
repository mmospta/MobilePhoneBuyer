//
//  SceneListWorker.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol SceneListStoreProtocol {
  func getData(_ completion: @escaping (Result<[PhoneElement], APIError>) -> Void)
}

class SceneListWorker {
  
  var store: SceneListStoreProtocol
  
  init(store: SceneListStoreProtocol) {
    self.store = store
  }
  
  func getPhone(_ completion: @escaping (Result<[PhoneElement], APIError>) -> Void) {
    store.getData {
      completion($0)
    }
  }
}
