//
//  THFeedViewDataSource.swift
//  THFeedView
//
//  Created by Juan Andres Vasquez Ferrer on 5/1/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import UIKit

public protocol THFeedViewDataSource: class {
    func getSections(for feedView: THFeedView) -> [BaseSection]
    func registerDecorationItems(layout: UICollectionViewCompositionalLayout)
}

public extension THFeedViewDataSource {
     func registerDecorationItems(layout: UICollectionViewCompositionalLayout) {}
}
