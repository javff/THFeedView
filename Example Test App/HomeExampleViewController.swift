//
//  HomeStyle1ViewController.swift
//  Example Test App
//
//  Created by Juan Andres Vasquez Ferrer on 5/11/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import UIKit
import THFeedView

protocol DataSectionProviderProtocol: class {
    func getData(result:@escaping(Result<[BaseSection], Error>) -> Void)
}

class HomeExampleViewController: UIViewController {
    
    var sections: [BaseSection] = []
    let feedViewProvider: FeedViewSectionProviderProtocol
    let margins: THFeedView.Margins
    let dataProvider: DataSectionProviderProtocol

    lazy var feedView: THFeedView = {
        let feedView = THFeedView(
            margins: self.margins,
            sectionProvider: self.feedViewProvider
        )
        registerSections()
        feedViewProvider.viewController = self
        feedView.dataSource = self
        feedView.backgroundColor = .tertiarySystemGroupedBackground
        self.view.addSubview(feedView)
        return feedView
    }()
    
    init(feedViewProvider: FeedViewSectionProviderProtocol,
         dataProvider: DataSectionProviderProtocol,
         margins: THFeedView.Margins) {
        self.margins = margins
        self.dataProvider = dataProvider
        self.feedViewProvider = feedViewProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getSections()
    }
    
    func getSections() {
        dataProvider.getData {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.sections = data
                self.feedView.reloadData()
            case .failure:
                break
            }
        }
    }
    
    private func registerSections() {
        feedViewProvider.registeredSections = [
            SectionType.trending.rawValue: TrendingSectionController.self,
            SectionType.quickReco.rawValue: QuickRecomendationsSectionController.self
        ]
    }
    
    private func setupView() {
        navigationItem.title = "Home"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        feedView.frame = view.bounds
    }
}

extension HomeExampleViewController: THFeedViewDataSource {
    
    func getSections(for feedView: THFeedView) -> [BaseSection] {
        return sections
    }
    
    func registerDecorationItems(layout: UICollectionViewCompositionalLayout) {
        layout.register(QuickRecoBackgroundView.self, forDecorationViewOfKind: QuickRecoBackgroundView.defaultReuseIdentifier)
    }
}

