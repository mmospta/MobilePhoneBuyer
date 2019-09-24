//
//  APIManager.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 17/9/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum APIError: Error {
  case invalidJSON
  case invalidData
}

class APIManager {
  func getPhones(completion: @escaping (Result<Phone, APIError>) -> Void) {
    let urlString = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
    AF.request(urlString).responseJSON { (response) in
      
      switch response.result {
      case .success:
        do{
          let phone = try JSONDecoder().decode(Phone.self, from: response.data!)
          completion(.success(phone))
        }catch{
          completion(.failure(APIError.invalidJSON))
        }
      case .failure:
        completion(.failure(APIError.invalidData))
      }
    }
  }
  
  func getDetailPhone(mobileId: Int, completion: @escaping (Result<DetailPhone, APIError>) -> Void) {
    let urlString = "https://scb-test-mobile.herokuapp.com/api/mobiles/\(mobileId)/images/"
    AF.request(urlString).responseJSON { (response) in
      
      switch response.result {
      case .success:
        do{
          let detailPhone = try JSONDecoder().decode(DetailPhone.self, from: response.data!)
          completion(.success(detailPhone))
        }catch{
          completion(.failure(APIError.invalidJSON))
        }
      case .failure:
        completion(.failure(APIError.invalidData))
      }
      
    }
  }
}
