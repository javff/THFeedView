//
//  THBaseDecorationItems.swift
//  THFeedView
//
//  Created by Juan Andres Vasquez Ferrer on 7/15/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import UIKit

public protocol SectionDecorationItem: class {
    
    func layoutDecorationItems() -> [NSCollectionLayoutDecorationItem]
    func registerDecorationItems(layout: UICollectionViewCompositionalLayout)
}
