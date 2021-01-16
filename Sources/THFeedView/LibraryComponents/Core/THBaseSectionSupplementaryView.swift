//
//  THBaseSectionSupplementaryView.swift
//  THFeedView
//
//  Created by Juan Andres Vasquez Ferrer on 7/14/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import UIKit

public protocol SectionSupplementaryView: class {
    func createSupplementaryView(in collectionView: UICollectionView,kind: String, indexPath: IndexPath) -> UICollectionReusableView?
    func layoutBoundarySuplementaryView() -> [NSCollectionLayoutBoundarySupplementaryItem]
}
