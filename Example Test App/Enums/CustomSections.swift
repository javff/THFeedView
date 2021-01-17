//
//  MySections.swift
//  Example Test App
//
//  Created by Juan Andres Vasquez Ferrer on 5/11/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import THFeedView

struct CustomSection: BaseSection {
   
    var sectionType: String {
        return type.rawValue
    }
    let id: String
    let type: SectionType
    var data: [AnyHashable]
    
    
}


enum SectionType: String {
    case trending = "trending"
    case quickReco = "quickReco"
}
