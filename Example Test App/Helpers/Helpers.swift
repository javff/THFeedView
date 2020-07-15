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
                    TrendingModel(id: "id1",
                                  image_url: "geek",
                                  title: "Geek",
                                  description: "Descubre"),
                    TrendingModel(id: "id2",
                    image_url: "geek",
                    title: "Geek",
                    description: "Descubre"),
                    TrendingModel(id: "id3",
                    image_url: "geek",
                    title: "Geek",
                    description: "Descubre"),
                    TrendingModel(id: "id4",
                    image_url: "geek",
                    title: "Geek",
                    description: "Descubre")
                ]
            )]
    }
}
