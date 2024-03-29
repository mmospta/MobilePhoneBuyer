//
//  ListViewCell.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 17/9/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ListViewCell: UITableViewCell {
  
  var favouriteButtonAction: (() -> Void)?
  
  @IBOutlet private weak var phoneImageView: UIImageView!
  @IBOutlet private weak var phoneNameLabel: UILabel!
  @IBOutlet private weak var phoneDescriptionLabel: UILabel!
  @IBOutlet private weak var priceLabel: UILabel!
  @IBOutlet private weak var ratingLabel: UILabel!
  @IBOutlet private weak var favouriteButton: UIButton!
  
  
  func configCell(phone: PhoneElement, favouriteId: [Int]) {
    phoneNameLabel.text = phone.brand
    priceLabel.text = "Price: $\(phone.price)"
    ratingLabel.text = "Rating: \(phone.rating)"
    phoneDescriptionLabel.text = phone.phoneDescription
    phoneImageView.kf.setImage(with: URL(string: phone.thumbImageURL))
    
    if favouriteId.contains(phone.id){
      favouriteButton.isSelected = true
    }else{
      favouriteButton.isSelected = false
    }
  }
  
  func hiddenFavouriteButton(state: HiddenFavouriteButton) {
    if state == .hidden{
      favouriteButton.isHidden = true
    }else{
      favouriteButton.isHidden = false
    }
  }
  
  
  @IBAction func favouriteButton(_ sender: UIButton) {
    favouriteButtonAction?()
  }
  
}
