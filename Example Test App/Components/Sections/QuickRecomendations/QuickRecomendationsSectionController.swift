//
//  QuickRecomendationsSectionController.swift
//  Example Test App
//
//  Created by Juan Andres Vasquez Ferrer on 7/15/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import THFeedView
import UIKit

struct QuickRecomendationsSectionModel: Codable & Hashable {
    let id: String
    let price: Float
    let image_url: String
    let title: String
    let description: String
}

class QuickRecomendationsSectionController: BaseSectionController<QuickRecomendationsSectionModel> {
    
    override func createCell(in collectionView: UICollectionView, indexPath: IndexPath, model: QuickRecomendationsSectionModel) -> UICollectionViewCell {
        
        let cell: QuickRecoViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.imageView.image = UIImage(named: model.image_url)
        cell.descriptionLabel.text = "\(model.title) \(model.description)"
        cell.priceLabel.text = model.price.prettyPrice
        return cell
    }
    
    override func createLayout(isWide: Bool) -> NSCollectionLayoutSection {
        THFeedLayouts.previewItemsLayout()
    }
}

extension QuickRecomendationsSectionController: SectionSupplementaryView {
    func layoutBoundarySuplementaryView() -> [NSCollectionLayoutBoundarySupplementaryItem] {

        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44.0)
        )
        

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: size,
            elementKind:  UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: size,
            elementKind:  UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )

        return [sectionHeader, sectionFooter]
    }

    func createSupplementaryView(in collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            let header: TitleHeaderView = collectionView.dequeueReusableView(indexPath: indexPath, supplementaryViewOfKind: kind)

            header.label.text = "Recomendaciones"
            header.label.textAlignment = .left
            header.layer.cornerRadius = 10
            header.layer.masksToBounds = true
            header.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            return header
        }

        if kind == UICollectionView.elementKindSectionFooter {
            let footer: NavigationButtonView = collectionView.dequeueReusableView(indexPath: indexPath, supplementaryViewOfKind: kind)
            
            footer.backgroundColor = .white
            footer.layer.cornerRadius = 10
            footer.layer.masksToBounds = true
            footer.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            footer.actionButton.setTitle("Ver más", for: .normal)
            return footer
        }

        return nil
    }
}


extension QuickRecomendationsSectionController: SectionDecorationItem {
   
    func layoutDecorationItems() -> [NSCollectionLayoutDecorationItem] {
        let item = NSCollectionLayoutDecorationItem.background(elementKind: QuickRecoBackgroundView.defaultReuseIdentifier)
        return [item]
    }
}
