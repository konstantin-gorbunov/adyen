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
    
    func registerForHeader(_ instantiatable: NibInstantiatable.Type) {
        register(
            UINib(nibName: instantiatable.nibIdentifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: instantiatable.nibIdentifier
        )
    }
    
    func dequeueCell<T: NibInstantiatable>(at indexPath: IndexPath) -> T where T: UICollectionViewCell {
        return T.dequeue(in: self, at: indexPath)
    }
    
    func dequeueHeader<T: NibInstantiatable>(at indexPath: IndexPath) -> T where T: UICollectionReusableView {
        return T.dequeue(in: self, kind: UICollectionView.elementKindSectionHeader, at: indexPath)
    }
}
