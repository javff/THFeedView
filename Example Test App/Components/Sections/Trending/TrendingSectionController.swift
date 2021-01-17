//
//  TrendingSectionController.swift
//  Example Test App
//
//  Created by Juan Andres Vasquez Ferrer on 5/11/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import UIKit
import THFeedView

struct TrendingModel: Decodable & Hashable {
    let id: String
    let image_url: String
    let title: String
    let description: String
}

class TrendingSectionController: BaseSectionController<TrendingModel> {
    
    override func createCell(in collectionView: UICollectionView, indexPath: IndexPath, model: TrendingModel) -> UICollectionViewCell {
        
        let cell: TrendingCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.imageView.image = UIImage(named: model.image_url)
        cell.title.text = model.title
        return cell
    }
    
    override func createLayout(isWide: Bool) -> NSCollectionLayoutSection {
        THFeedLayouts.simpleCardLayout()
    }
}

