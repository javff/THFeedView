//
//  ExamplesUseCases.swift
//  Example Test App
//
//  Created by Juan Andres Vasquez Ferrer on 7/17/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import THFeedView
import UIKit

enum Example: CaseIterable {
    
    case exampleStyle1
    
    func getController() -> UIViewController {
        
        let feedViewProvider = FeedViewSectionProvider()
        
        switch self {
        case .exampleStyle1:
            let controller = HomeExampleViewController(
                feedViewProvider: feedViewProvider,
                dataProvider: Example1DataProvider(),
                margins: .init(interSectionSpacing: 30, topSpacing: 30, bottomSpacing: 30))
            return controller
        }
    }
    
    
    var name: String {
        switch self {
        case .exampleStyle1:
            return "Basic Example"
        }
    }
}
