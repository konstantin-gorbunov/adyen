//
//  BaseCollectionViewController.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 12/01/2022.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {

     struct Constants {
        static let itemsInRow = 1
        static let lineSpacing: CGFloat = 0
        static let rowSpacing: CGFloat = 0
        static let headerHeight: CGFloat = 50

        static func cellWidth(in view: UIView) -> CGFloat {
            assert(itemsInRow >= 0)
            let availableWidth = view.bounds.width - (lineSpacing * CGFloat(itemsInRow - 1))
            return availableWidth / CGFloat(itemsInRow)
        }
    }

    var flowLayout: UICollectionViewFlowLayout? {
        return collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
    }

    func configureCell(_ cell: LocationViewCell, at indexPath: IndexPath) {
        /* Call in subclass to configure Cell */
    }
    
    func configureHeader(_ header: SectionHeader, at indexPath: IndexPath) {
        /* Call in subclass to configure Cell */
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        flowLayout?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout?.minimumLineSpacing = Constants.lineSpacing
        flowLayout?.minimumInteritemSpacing = Constants.rowSpacing
        flowLayout?.headerReferenceSize = CGSize(width: collectionView.frame.size.width, height: Constants.headerHeight)

        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = .white
        collectionView?.registerForCell(LocationViewCell.self)
        collectionView?.registerForHeader(SectionHeader.self)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fatalError("Should be overriden in subclass")
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LocationViewCell = collectionView.dequeueCell(at: indexPath)
        configureCell(cell, at: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: SectionHeader = collectionView.dequeueHeader(at: indexPath)
        configureHeader(header, at: indexPath)
        return header
    }
}
