//
//  SceneDetailStore.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Foundation

/*

 The SceneDetailStore class implements the SceneDetailStoreProtocol.

 The source for the data could be a database, cache, or a web service.

 You may remove these comments from the file.

 */

class SceneDetailStore: SceneDetailStoreProtocol {
  func getData(_ completion: @escaping (Result<Entity>) -> Void) {
    // Simulates an asynchronous background thread that calls back on the main thread after 2 seconds
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      completion(Result.success(Entity()))
    }
  }
}
