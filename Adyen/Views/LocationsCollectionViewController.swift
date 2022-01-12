//
//  LocationsCollectionViewController.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 12/01/2022.
//

import UIKit

protocol LocationCollectionViewDelegate: AnyObject {
    func didChangeRadius(_ radius: Int)
}

protocol LocationListViewModelUpdateDelegate: AnyObject {
    func didModelUpdated(_ viewModel: LocationListViewModel)
}

final class LocationsCollectionViewController: BaseCollectionViewController {
    
    weak var delegate: LocationCollectionViewDelegate?

    private var viewModel: LocationListViewModel
    private var sectionViewModel: SectionHeaderViewModel?
    
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
    
    override func configureHeader(_ header: SectionHeader, at indexPath: IndexPath) {
        header.delegate = self
        header.viewModel = sectionViewModel
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

extension LocationsCollectionViewController: LocationListViewModelUpdateDelegate {
    
    func didModelUpdated(_ viewModel: LocationListViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
}

extension LocationsCollectionViewController: SectionHeaderDelegate {
    func valueChanged(_ value: Int) {
        delegate?.didChangeRadius(value)
        sectionViewModel = SectionHeaderViewModel(value: value)
    }
}
