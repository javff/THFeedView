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
    
    //MARK: - UIVars
    private lazy var collectionView: UICollectionView = {
        let layout = self.generateLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        return collectionView
    }()
    
    //MARK: - Vars
    public weak var dataSource: THFeedViewDataSource?
    public weak var delegate: THFeedViewDelegate?
    
    private let sectionProvider: SectionProviderProtocol
    private var collectionDataSource: CustomDataSource!
    private var snapshot = CustomSnapshot()
    
    
    private var sections: [BaseSection] {
        guard let sections = dataSource?.getSections(for: self) else {
            fatalError("DataSource must be implement")
        }
        return sections
    }
    
    //MARK: - Inits
     public init(frame: CGRect = .zero, sectionProvider: SectionProviderProtocol) {
        self.sectionProvider = sectionProvider
        super.init(frame: frame)
        initComponent()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - funcs
    
    private func initComponent() {
        sectionProvider.registerCells(in: collectionView)
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
        for section in sections {
            let sc = sectionProvider.create(section: section)
            sc.configureSnapshot(snapshot: &snapshot)
        }
    }
    
    private func configureDataSource() {
        collectionDataSource = CustomDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, element) -> UICollectionViewCell? in
            
            let sectionController = self.sectionProvider.find(sectionIndex: indexPath.section)
            return sectionController?.createCell(in: collectionView, indexPath: indexPath, model: element)
        })
        
        configureSnapshots()
        collectionDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    public func reloadData() {
        configureDataSource()
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if self.sections.isEmpty { return THFeedLayouts.fullWindowLayout(isWide: false)}
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
            let section = self.sections[sectionIndex]
            return self.sectionProvider.createLayout(for: section, isWide: isWideView)
        }
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
