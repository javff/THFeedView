//
//  THFeedView.swift
//  THFeedView
//
//  Created by Juan Andres Vasquez Ferrer on 5/1/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import UIKit

public class THFeedView: UIView {
    
    public struct Margins {
         let interSectionSpacing: CGFloat
         let topSpacing: CGFloat
         let bottomSpacing: CGFloat
        
        public init(interSectionSpacing: CGFloat,
                    topSpacing: CGFloat,
                    bottomSpacing: CGFloat) {
            self.interSectionSpacing = interSectionSpacing
            self.bottomSpacing = bottomSpacing
            self.topSpacing = topSpacing
        }
    }
        
    //MARK: - UIVars
    private lazy var collectionView: UICollectionView = {
        let layout = self.generateLayout()
        self.dataSource?.registerDecorationItems(layout: layout)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: self.margins.topSpacing, left: 0, bottom: self.margins.bottomSpacing, right: 0)
        return collectionView
    }()
    
    //MARK: - Vars
    public weak var dataSource: THFeedViewDataSource? {
        didSet {
            initComponent()
        }
    }
    public weak var delegate: THFeedViewDelegate?

    public let margins: Margins
    private let sectionProvider: FeedViewSectionProviderProtocol
    private var collectionDataSource: CustomDataSource!
    private var snapshot = CustomSnapshot()
    
    
    private var sections: [BaseSection] {
        guard let sections = dataSource?.getSections(for: self) else {
            fatalError("DataSource must be implement")
        }
        return sections
    }
    
    //MARK: - Inits
    public init(margins: Margins, sectionProvider: FeedViewSectionProviderProtocol) {
        self.sectionProvider = sectionProvider
        self.margins = margins
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - funcs
    
    private func initComponent() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureSnapshots() {
       self.sections.compactMap({sectionProvider.create(section: $0)}).forEach {
            $0.configureSnapshot(snapshot: &snapshot)
        }
    }
    
    private func configureDataSource() {
        collectionDataSource = CustomDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, element) -> UICollectionViewCell? in
            
            let sectionController = self.sectionProvider.find(sectionIndex: indexPath.section)
            return sectionController?.createCell(in: collectionView, indexPath: indexPath, model: element)
        })
            
        collectionDataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let sectionController = self.sectionProvider.find(sectionIndex: indexPath.section) as? SectionSupplementaryView else {
                return nil
            }
            
            return sectionController.createSupplementaryView(in: self.collectionView, kind: kind, indexPath: indexPath)
        }
        
        configureSnapshots()
        collectionDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    public func reloadData() {
        configureDataSource()
    }
    
    private func generateLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard !self.sections.isEmpty else {
                return THFeedLayouts.simpleCardLayout()
            }
            
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
            
            let section = self.sections[sectionIndex]
            
            guard let sc = self.sectionProvider.find(section: section) else {
                return THFeedLayouts.simpleCardLayout()
            }
            
            let layoutSection = sc.createLayout(isWide: isWideView)
            
            if let sectionSupplementaryView = sc as? SectionSupplementaryView {
                layoutSection.boundarySupplementaryItems = sectionSupplementaryView.layoutBoundarySuplementaryView()
            }
            
            if let decorationView = sc as? SectionDecorationItem {
                layoutSection.decorationItems = decorationView.layoutDecorationItems()
            }
            
            return layoutSection
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = self.margins.interSectionSpacing
        layout.configuration = config
        return layout
    }
}

extension THFeedView: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        if let sc = sectionProvider.find(section: section),
            let item = collectionDataSource.itemIdentifier(for: indexPath) {
            sc.feedView(self, didSelect: item)
        }
    }
}
