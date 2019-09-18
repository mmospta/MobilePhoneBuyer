//
//  SceneListModels.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit
import SwiftyJSON

struct SceneList {
  /// This structure represents a use case
  struct GetPhone {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {
      let responseData: Phone
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let passData: Phone
      
    }
    
  }
}
