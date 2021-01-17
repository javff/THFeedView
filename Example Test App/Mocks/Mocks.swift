//
//  Mocks.swift
//  Example Test App
//
//  Created by Juan Andres Vasquez Ferrer on 5/11/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import THFeedView

class Example1DataProvider: DataSectionProviderProtocol {
    
    func getData(result: @escaping (Result<[BaseSection], Error>) -> Void) {
        result(.success(sections))
    }
    
    let sections: [BaseSection] = [
    CustomSection(
        id: "id1",
        type: .trending,
        data: [
            TrendingModel(id: "1",
                          image_url: "geek",
                          title: "Geek",
                          description: "Descubre")
        ]
    ),
    CustomSection(
        id: "id2",
        type: .quickReco,
        data: [
            QuickRecomendationsSectionModel(
                id: "1",
                price: 1000.0,
                image_url: "laptop",
                title: "Asus",
                description: "laptop x409fb-ek016t"),
            QuickRecomendationsSectionModel(
                                id: "1",
                                price: 1000.0,
                                image_url: "laptop2",
                                title: "Asus",
                                description: "laptop x409fb-ek016t"),
            QuickRecomendationsSectionModel(
                                id: "1",
                                price: 1000.0,
                                image_url: "laptop",
                                title: "Geek",
                                description: "Descubre"),
            QuickRecomendationsSectionModel(
                                id: "1",
                                price: 1000.0,
                                image_url: "laptop2",
                                title: "Geek",
                                description: "Descubre")
    ]),
        CustomSection(
            id: "id10",
            type: .trending,
            data: [
                TrendingModel(id: "1111",
                              image_url: "geek",
                              title: "Geek",
                              description: "Descubre")
            ]
        )
    ]
}
