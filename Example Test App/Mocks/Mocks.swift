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
        
        if let path = Bundle.main.path(forResource: "Example1", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode([FeedSection].self, from: data)
                result(.success(response))
            } catch (let error) {
                result(.failure(error))
            }
        }
        
    }
}
