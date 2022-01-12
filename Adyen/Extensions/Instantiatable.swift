//
//  Instantiatable.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 12/01/2022.
//

import UIKit

protocol NibInstantiatable {
    static var nibIdentifier: String { get }
}

extension NibInstantiatable {
    static var nibIdentifier: String {
        return String(describing: self)
    }
}

extension NibInstantiatable where Self: UICollectionViewCell {
    static func dequeue(in collectionView: UICollectionView, at indexPath: IndexPath) -> Self {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nibIdentifier, for: indexPath) as? Self else {
                fatalError("Can't dequeue \(self) with \(collectionView) at \(indexPath)!")
        }
        return cell
    }
}
