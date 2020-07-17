//
//  QuickRecoBackgroundView.swift
//  Example Test App
//
//  Created by Juan Andres Vasquez Ferrer on 7/15/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import UIKit
import THFeedView

class QuickRecoBackgroundView: UICollectionReusableView, ReusableView {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = .tertiarySystemGroupedBackground
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        applyStyle()
        
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor,constant:  16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17.5)
        ])
    }
    
    private func applyStyle () {
        backgroundColor = .clear
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 12
        layer.shadowOpacity = 0.7
    }
}
