//
//  THServiceProvider.swift
//  THFeedView
//
//  Created by Juan Andres Vasquez Ferrer on 5/1/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import UIKit

public protocol FeedViewSectionProviderProtocol: class {
    var  registeredSections:[String: BaseSectionControllerProtocol.Type]  { get set }
    var  viewController: UIViewController? { get set }
    func create(section: BaseSection) -> BaseSectionControllerProtocol?
    func find(section: BaseSection) -> BaseSectionControllerProtocol?
    func find(sectionIndex position: Int) -> BaseSectionControllerProtocol?
}

open class FeedViewSectionProvider: NSObject, FeedViewSectionProviderProtocol {
    
    public var registeredSections:[String: BaseSectionControllerProtocol.Type] = [:]
    public weak var viewController: UIViewController?
    private var cacheSections:[BaseSectionControllerProtocol] = []
    
    final public func create(section: BaseSection) -> BaseSectionControllerProtocol? {
        guard let SectionControllerType = registeredSections[section.sectionType] else {
            return nil
        }
        let sectionController = SectionControllerType.init(section: section, viewController: viewController)
        cacheSections.append(sectionController)
        return sectionController
    }
    
    final public func find(section: BaseSection) -> BaseSectionControllerProtocol? {
        return cacheSections.first { section.id == $0.section.id }

    }
    
    final public func find(sectionIndex position: Int) -> BaseSectionControllerProtocol? {
        return cacheSections[position]
    }    
}
