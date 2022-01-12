//
//  LocationsCollectionViewController.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 12/01/2022.
//

import UIKit

final class LocationsCollectionViewController: BaseCollectionViewController {
    
    private var viewModel: LocationListViewModel
    
    init(viewModel: LocationListViewModel, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
    }
    
    override func configureCell(_ cell: LocationViewCell, at indexPath: IndexPath) {
        cell.viewModel = LocationViewModel(viewModel.locations[indexPath.row])
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.locations.count
    }
}

extension LocationsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.cellWidth(in: view), height: flowLayout?.itemSize.height ?? 0)
    }
}
