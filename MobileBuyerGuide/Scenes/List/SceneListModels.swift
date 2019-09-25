//
//  SceneListModels.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit
import SwiftyJSON

enum SegmentControlState {
  case all
  case favourite
}

enum SortType {
  case none
  case priceLowToHigh
  case priceHighToLow
  case ratingHighToLow
}

struct SceneList {
  
  struct GetPhone {
    
    struct Request {
      let state: SegmentControlState
    }
    
    struct Response {
      let responseData: [PhoneElement]
    }
    
    struct ViewModel {
      let passData: [PhoneElement]
    }
  }
  
  struct SortPhone {
    struct Request {
      let sortType: SortType
    }
    
  }
  
  struct TapFavourite {
    struct Request {
      let favouriteId: Int
    }
    struct Response {
      let favouriteId: [Int]
    }
    struct ViewModel {
      let favouriteId: [Int]
    }
  }
  
  struct TapSelectRow {
    struct Request {
      let responseData: PhoneElement
    }
    struct Response {
      let responseData: PhoneElement
    }
    struct ViewModel {
      
    }
  }
}
