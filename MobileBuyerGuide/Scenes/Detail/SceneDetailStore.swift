//
//  SceneDetailStore.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Foundation

class SceneDetailStore: SceneDetailStoreProtocol {
  let apiManager = APIManager()
  func getData(mobileId: Int, _ completion: @escaping (Result<DetailPhone, APIError>) -> Void) {
    self.apiManager.getDetailPhone(mobileId: mobileId) { (response) in
      completion(response)
    }
  }
}
