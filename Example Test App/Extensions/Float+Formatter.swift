//
//  Float+Formatter.swift
//  Example Test App
//
//  Created by Juan Andres Vasquez Ferrer on 7/16/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation


extension Float {
    
    var prettyPrice: String? {
        return formmater()
    }
    
    private func formmater() -> String? {
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            return formattedTipAmount
        }
        return nil
    }
}
