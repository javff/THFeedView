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
    
    var id: String { get }
    var type: String { get }
    
  func configureDataSource(in collectionView: UICollectionView, with dataSource: inout CustomDataSource)
    
    func createCell(in collectionView: UICollectionView,
                    indexPath: IndexPath, model: AnyHashable) -> UICollectionViewCell
    
    func feedView(_ feedView: THFeedView, didSelect item: AnyHashable)
            
    func configureSnapshot(snapshot: inout CustomSnapshot)
    
    func createLayout(isWide: Bool) -> NSCollectionLayoutSection
    
    init(section: BaseSection, viewController: UIViewController?)
}

extension Encodable {
    func mlvpp_asDictionary() throws -> [String: Any] {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try jsonEncoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }

    func mlvpp_encode() throws -> Data {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        return try jsonEncoder.encode(self)
    }
}

extension Decodable {
    static func mlvpp_decode(fromJsonData jsonData: Data) throws -> Self {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(self, from: jsonData)
    }

    static func mlvpp_decode(fromDictionary dictionary: [AnyHashable: Any]) throws -> Self {
        return try Self.mlvpp_decode(withJSONObject: dictionary)
    }

    static func mlvpp_decode(fromArray array: [Any]) throws -> Self {
        return try Self.mlvpp_decode(withJSONObject: array)
    }

    private static func mlvpp_decode(withJSONObject object: Any) throws -> Self {
        let jsonData = try JSONSerialization.data(withJSONObject: object, options: [])
        return try Self.mlvpp_decode(fromJsonData: jsonData)
    }
}



open class BaseSectionController<T: Decodable & Hashable>: NSObject, BaseSectionControllerProtocol {
        
    public let id: String
    public let type: String
    public let data:[T]
    public weak var viewController: UIViewController?
    
    public required init(section: BaseSection, viewController: UIViewController?) {
        self.id = section.id
        self.type = section.type
        let jsonDecorder = JSONDecoder()
        self.data = section.data.compactMap {
            guard let data = try? $0.mlvpp_encode() else { return nil }
            return try? jsonDecorder.decode(T.self, from: data)
        }
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
    
    open func createLayout(isWide: Bool) -> NSCollectionLayoutSection {
        return THFeedLayouts.simpleCardLayout()
    }

    final public func configureSnapshot(snapshot: inout CustomSnapshot) {
        guard !snapshot.sectionIdentifiers.contains(id) else {
            NSLog("Id \(id) is repeteat. Ignoring section ...")
            return
        }
        snapshot.appendSections([id])
        snapshot.appendItems(data)
    }
    
}
