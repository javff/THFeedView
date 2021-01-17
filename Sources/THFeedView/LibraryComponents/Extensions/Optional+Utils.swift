//
//  Optional+Utils.swift
//  THFeedView
//
//  Created by Juan Andres Vasquez Ferrer on 17-01-21.
//  Copyright © 2021 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation

extension Optional {
    func or(_ other: Optional) -> Optional {
        switch self {
        case .none: return other
        case .some: return self
        }
    }
}

extension Optional where Wrapped == String {
    func mlvpp_nilIfEmpty() -> Self {
        return self?.isEmpty == false ? self : nil
    }

    func mlvpp_isEmptyOrNil() -> Bool {
        return self?.isEmpty != false
    }
}
