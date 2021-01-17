//
//  Codable+JSONValue.swift
//  THFeedView
//
//  Created by Juan Andres Vasquez Ferrer on 17-01-21.
//  Copyright © 2021 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation

public enum JsonValue: Codable, Hashable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case object([String: JsonValue])
    case array([JsonValue])

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        guard let value = ((try? container.decode(String.self)).map(JsonValue.string))
            .or((try? container.decode(Int.self)).map(JsonValue.int))
            .or((try? container.decode(Double.self)).map(JsonValue.double))
            .or((try? container.decode(Bool.self)).map(JsonValue.bool))
            .or((try? container.decode([String: JsonValue].self)).map(JsonValue.object))
            .or((try? container.decode([JsonValue].self)).map(JsonValue.array))
            else {
                throw DecodingError.typeMismatch(JsonValue.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Not a JSON"))
        }
        self = value
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
            break
        case .int(let value):
            try container.encode(value)
            break
        case .object(let value):
            try container.encode(value)
            break
        case .double(let value):
            try container.encode(value)
            break
        case .bool(let value):
            try container.encode(value)
            break
        case .array(let value):
            try container.encode(value)
            break
        }
    }
}
