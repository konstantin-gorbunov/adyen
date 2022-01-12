//
//  UICollectionView.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 12/01/2022.
//

import UIKit

extension UICollectionView {
    func registerForCell(_ instantiatable: NibInstantiatable.Type) {
        register(
            UINib(nibName: instantiatable.nibIdentifier, bundle: nil),
            forCellWithReuseIdentifier: instantiatable.nibIdentifier
        )
    }
    
    func dequeueCell<T: NibInstantiatable>(at indexPath: IndexPath) -> T where T: UICollectionViewCell {
        return T.dequeue(in: self, at: indexPath)
    }
}
