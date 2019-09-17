//
//  ListViewCell.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 17/9/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import UIKit

class ListViewCell: UITableViewCell {
    
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var phoneNameLabel: UILabel!
    
    @IBOutlet weak var phoneDescriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
}
