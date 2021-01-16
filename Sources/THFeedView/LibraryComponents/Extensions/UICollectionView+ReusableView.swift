//
//  UICollectionView+ReusableView.swift
//  THFeedView
//
//  Created by Juan Andres Vasquez Ferrer on 7/13/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
  
    private func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    private func register<T: UICollectionReusableView>(_: T.Type, supplementaryViewOfKind: String) where T: ReusableView {
        register(T.self, forSupplementaryViewOfKind: supplementaryViewOfKind, withReuseIdentifier: T.defaultReuseIdentifier)
     }
   
    private func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    private func register<T: UICollectionReusableView>(_: T.Type, supplementaryViewOfKind: String) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: supplementaryViewOfKind, withReuseIdentifier: T.defaultReuseIdentifier)
     }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: ReusableView, T: NibLoadableView {
        register(T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Verify register extension")
        }
        return cell
    }
    
    public func dequeueReusableView<T: UICollectionReusableView>(indexPath: IndexPath, supplementaryViewOfKind: String) -> T where T: ReusableView {
        register(T.self, supplementaryViewOfKind: supplementaryViewOfKind)
        guard let view = dequeueReusableSupplementaryView(ofKind: supplementaryViewOfKind, withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Verify register extension")
        }
        return view
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: ReusableView {
        register(T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Verify register extension")
        }
        return cell
    }
    
    public func dequeueReusableView<T: UICollectionReusableView>(indexPath: IndexPath, supplementaryViewOfKind: String) -> T where T: ReusableView, T: NibLoadableView {
        register(T.self, supplementaryViewOfKind: supplementaryViewOfKind)
        guard let view = dequeueReusableSupplementaryView(ofKind: supplementaryViewOfKind, withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Verify register extension")
        }
        return view
    }
}

