//
//  FeedSection.swift
//  THFeedView
//
//  Created by Juan Andres Vasquez Ferrer on 17-01-21.
//  Copyright © 2021 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation

public struct FeedSection: BaseSection, Decodable {
   
    public let id: String
    public let type: String
    public let data: [[String: JsonValue]]
    
    private enum CodingKeys: CodingKey {
        case id, type, data
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.id = try container.decode(String.self, forKey: .id)
        self.data = try container.decode([[String: JsonValue]].self, forKey: .data)
    }
}
