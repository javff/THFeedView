//
//  QuickRecoView.swift
//  Example Test App
//
//  Created by Juan Andres Vasquez Ferrer on 7/15/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import UIKit
import THFeedView

class QuickRecoViewCell: UICollectionViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}
