//
//  Helpers.swift
//  Example Test App
//
//  Created by Juan Andres Vasquez Ferrer on 5/11/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import THFeedView

class Helpers {
    
    class func generateMocks() -> [BaseSection] {
        return [
            CustomSection(
                id: "id1",
                type: .trending,
                data: [
                    TrendingModel(id: "id1", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                TrendingModel(id: "id2", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                TrendingModel(id: "id3", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                TrendingModel(id: "id4", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                TrendingModel(id: "id5", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                TrendingModel(id: "id6", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                TrendingModel(id: "id7", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                TrendingModel(id: "id8", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                TrendingModel(id: "id9", image_url: "testing", title: "Trending Top", description: "Testing trending top")
                ]
            ),
            CustomSection(
                id: "id2",
                type: .trending,
                data: [
                    TrendingModel(id: "i1", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                    TrendingModel(id: "i2", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                    TrendingModel(id: "i3", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                    TrendingModel(id: "i4", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                    TrendingModel(id: "i5", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                    TrendingModel(id: "i6", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                    TrendingModel(id: "i7", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                    TrendingModel(id: "i8", image_url: "testing", title: "Trending Top", description: "Testing trending top"),
                    TrendingModel(id: "i9", image_url: "testing", title: "Trending Top", description: "Testing trending top")
                ]
            )
        ]
    }
}
