//
//  SceneDetailModels.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

struct SceneDetail {
  /// This structure represents a use case
  struct Something {
    struct Request {}
    struct Response {
      let responseData: DetailPhone
    }
    struct ViewModel {
      let url: [String]
    }
  }
  
  struct GetDetailPhone {
    struct Request {}
    
    struct Response {
      let mobileDataAtRow: PhoneElement
    }
    struct ViewModel {
      let price: Double
      let rating: Double
      let description: String
    }
  }
}
