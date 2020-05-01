//
//  BaseSectionController.swift
//  THFeedView
//
//  Created by Juan Andres Vasquez Ferrer on 5/1/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import UIKit

public typealias CustomDataSource = UICollectionViewDiffableDataSource<String,AnyHashable>
public typealias CustomSnapshot = NSDiffableDataSourceSnapshot<String, AnyHashable>

public protocol BaseSectionControllerProtocol: AnyObject {
    
  var section: BaseSection { get }
    
  func configureDataSource(in collectionView: UICollectionView, with dataSource: inout CustomDataSource)
    
    func createCell(in collectionView: UICollectionView,
                    indexPath: IndexPath, model: AnyHashable) -> UICollectionViewCell
        
    func configureSnapshot(snapshot: inout CustomSnapshot)
}

