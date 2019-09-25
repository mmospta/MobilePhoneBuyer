//
//  Phone.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 17/9/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation

// MARK: - PhoneElement
struct PhoneElement: Codable {
    let brand: String
    let thumbImageURL: String
    let phoneDescription: String
    let rating: Double
    let id: Int
    let price: Double
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case brand, thumbImageURL
        case phoneDescription = "description"
        case rating, id, price, name
    }
}

struct DetailPhoneElement: Codable {
  let id: Int
  let url: String
  let mobileID: Int
  
  enum CodingKeys: String, CodingKey {
    case id, url
    case mobileID = "mobile_id"
  }
}


