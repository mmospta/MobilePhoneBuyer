//
//  DetailCollectionViewCell.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 24/9/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit
import Kingfisher

class DetailCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet private weak var phoneImageView: UIImageView!
  
  func configCell(url: String)  {
    phoneImageView.kf.setImage(with: URL(string: url))    
  }
}
