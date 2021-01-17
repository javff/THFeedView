//
//  THBaseCell.swift
//  THFeedView
//
//  Created by Juan Andres Vasquez Ferrer on 5/1/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation

public protocol BaseSection: Any {
    var id: String { get }
    var sectionType: String { get }
    var data: [AnyHashable] { get }
}

public extension Decodable {
    func decodedHashable<T: Hashable & Decodable>(_ type: T, data: Data) -> [AnyHashable] {
        let jsonDecoder = JSONDecoder()
        let info = try? jsonDecoder.decode([T].self, from: data)
        return info ?? []
    }
}
