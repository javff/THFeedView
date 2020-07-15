//
//  ViewController.swift
//  Example Test App
//
//  Created by Juan Andres Vasquez Ferrer on 5/11/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import UIKit
import THFeedView

class ExampleViewController: UIViewController {
    
    var sectionsMock: [BaseSection] = []
    
    let sectionProvider: SectionProviderProtocol

    lazy var feedView: THFeedView = {
        let feedView = THFeedView(sectionProvider: self.sectionProvider)
        feedView.dataSource = self
        feedView.backgroundColor = .blue
        self.view.addSubview(feedView)
        return feedView
    }()
    
    init(sectionProvider: SectionProviderProtocol) {
        self.sectionProvider = sectionProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerSections()
        sectionProvider.viewController = self
        sectionsMock = Helpers.generateMocks()
        self.feedView.reloadData()
    }
    
    private func registerSections() {
        sectionProvider.registeredSections = [
            SectionType.trending.rawValue: TrendingSectionController.self
        ]
    }
    
    private func setupView() {
        navigationItem.title = "Example Home"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        feedView.frame = view.bounds
    }
}

extension ExampleViewController: THFeedViewDataSource {
    
    func getSections(for feedView: THFeedView) -> [BaseSection] {
        return sectionsMock
    }
}

