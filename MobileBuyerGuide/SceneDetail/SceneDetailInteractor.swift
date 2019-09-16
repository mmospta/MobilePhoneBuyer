//
//  SceneDetailInteractor.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol SceneDetailInteractorInterface {
  func doSomething(request: SceneDetail.Something.Request)
  var model: Entity? { get }
}

class SceneDetailInteractor: SceneDetailInteractorInterface {
  var presenter: SceneDetailPresenterInterface!
  var worker: SceneDetailWorker?
  var model: Entity?

  // MARK: - Business logic

  func doSomething(request: SceneDetail.Something.Request) {
    worker?.doSomeWork { [weak self] in
      if case let Result.success(data) = $0 {
        // If the result was successful, we keep the data so that we can deliver it to another view controller through the router.
        self?.model = data
      }

      // NOTE: Pass the result to the Presenter. This is done by creating a response model with the result from the worker. The response could contain a type like UserResult enum (as declared in the SCB Easy project) with the result as an associated value.
      let response = SceneDetail.Something.Response()
      self?.presenter.presentSomething(response: response)
    }
  }
}
