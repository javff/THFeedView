//
//  THServiceProvider.swift
//  THFeedView
//
//  Created by Juan Andres Vasquez Ferrer on 5/1/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import UIKit

public protocol SectionProviderProtocol: AnyObject {
    func create(section: BaseSection) -> BaseSectionControllerProtocol
    func find(section: BaseSection) -> BaseSectionControllerProtocol?
    func find(sectionIndex position: Int) -> BaseSectionControllerProtocol?
}
