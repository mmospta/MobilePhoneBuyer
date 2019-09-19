//
//  SceneListStore.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Foundation

class SceneListStore: SceneListStoreProtocol {
  let apiManager = APIManager()
  func getData(_ completion: @escaping (Result<Phone>) -> Void) {
    self.apiManager.getPhones(completion: { (response) in
      completion(response)
    })
  }
}

