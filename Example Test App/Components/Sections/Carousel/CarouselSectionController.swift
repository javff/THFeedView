//
//  CarouselSectionController.swift
//  Example Test App
//
//  Created by Cesar on 29-01-21.
//  Copyright © 2021 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import UIKit
import THFeedView

struct CarouselModel: Decodable & Hashable {
    let id: String
    let image_url: String
    let title: String
    let description: String
}

class CarouselSectionController: BaseSectionController<CarouselModel> {
    
    override func createCell(in collectionView: UICollectionView, indexPath: IndexPath, model: CarouselModel) -> UICollectionViewCell {
        
        let cell: CarouselCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.imageView.image = UIImage(named: model.image_url)
        return cell
    }
    
    override func createLayout(isWide: Bool) -> NSCollectionLayoutSection {
        THFeedLayouts.carouseLayout()
    }
}
