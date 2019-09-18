//
//  SceneListWorker.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol SceneListStoreProtocol {
  func getData(_ completion: @escaping (Result<Phone>) -> Void)
}

class SceneListWorker {

  var store: SceneListStoreProtocol

  init(store: SceneListStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic

  func doSomeWork(_ completion: @escaping (Result<Phone>) -> Void) {
    // NOTE: Do the work
    store.getData {
      completion($0)
    }
  }
}
