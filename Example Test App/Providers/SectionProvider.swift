//
//  SectionProvider.swift
//  Example Test App
//
//  Created by Juan Andres Vasquez Ferrer on 5/11/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import UIKit
import THFeedView

class CustomSectionProvider: SectionProviderProtocol {
    
    var cacheSections:[BaseSectionControllerProtocol] = []
    weak var controller: UIViewController?
   
    func create(section: BaseSection) -> BaseSectionControllerProtocol {
        guard let section = section as? CustomSection else { fatalError("") }
        
        switch section.type {
        case .trending:
            let trendingSC = TrendingSectionController(section: section, in: controller)
            cacheSections.append(trendingSC)
            return trendingSC
        }
    }
    
    func find(section: BaseSection) -> BaseSectionControllerProtocol? {
        return cacheSections.first { section.id == $0.section.id }
    }
    
    func find(sectionIndex position: Int) -> BaseSectionControllerProtocol? {
        return cacheSections[position]
    }    
}
