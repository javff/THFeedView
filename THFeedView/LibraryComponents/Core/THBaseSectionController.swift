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
    
    func feedView(_ feedView: THFeedView, didSelect item: AnyHashable)
    
    func createSupplementaryView(in collectionView: UICollectionView,kind: String, indexPath: IndexPath) -> UICollectionReusableView?
        
    func configureSnapshot(snapshot: inout CustomSnapshot)
    
    func createLayout(isWide: Bool) -> NSCollectionLayoutSection
}


open class BaseSectionController<T: Codable & Hashable>: NSObject, BaseSectionControllerProtocol {
    
    public let section: BaseSection
    public weak var viewController: UIViewController?
    
    public init(section: BaseSection, in viewController: UIViewController?) {
        self.section = section
        self.viewController = viewController
        super.init()
    }
           
    final public func configureDataSource(in collectionView: UICollectionView, with dataSource: inout CustomDataSource) {
        dataSource = CustomDataSource(collectionView: collectionView) { (collectionView, indexPath, model) -> UICollectionViewCell? in
            return self.createCell(in: collectionView, indexPath: indexPath, model: model)
        }
    }
    
    final public func createCell(in collectionView: UICollectionView, indexPath: IndexPath, model: AnyHashable) -> UICollectionViewCell {
        guard let model = model.base as? T else { fatalError("Verify model type") }
        return createCell(in: collectionView, indexPath: indexPath, model: model)
    }
    
    open func createCell(in collectionView: UICollectionView, indexPath: IndexPath, model: T) -> UICollectionViewCell {
           // only override
           fatalError("must be override")
       }
    
    final public func feedView(_ feedView: THFeedView, didSelect item: AnyHashable) {
        guard let model = item.base as? T else { fatalError("Verify model type") }
        self.feedView(feedView, didSelect: model)
    }
    
    open func feedView(_ feedView: THFeedView, didSelect item: T) {
        // only override
    }
    
    open func createSupplementaryView(in collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        // only override
        return nil
    }
    
    open func createLayout(isWide: Bool) -> NSCollectionLayoutSection {
        return THFeedLayouts.fullWindowLayout(isWide: isWide)
    }
    

    final public func configureSnapshot(snapshot: inout CustomSnapshot) {
        snapshot.appendSections([section.id])
        snapshot.appendItems(section.data)
    }
    
}
