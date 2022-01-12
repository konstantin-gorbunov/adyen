//
//  HomeCoordinator.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

import UIKit

/// Home (Location List) Coordinator
final class HomeCoordinator<T: Dependency>: Coordinator<T> {

    let navigationViewController: UINavigationController
    private let title = NSLocalizedString("Locations", comment: "Locations")
    private var locationUpdateDelegate: LocationListViewModelUpdateDelegate?

    init(dependency: T, navigation: UINavigationController) {
        navigationViewController = navigation
        super.init(dependency: dependency)
    }
    
    override func start() {
        super.start()

        let loadingViewController = LoadingViewController(nibName: nil, bundle: nil)
        navigationViewController.viewControllers = [loadingViewController]
        loadingViewController.title = title

        dependency.dataProvider.fetchLocationList { result in
            DispatchQueue.main.async { [weak self] in
                self?.processResults(result)
            }
        }
    }

    private func processResults(_ result: DataProvider.FetchLocationResult) {
        guard case .success(let locations) = result, locations.isEmpty == false else {
            var dataProviderError: DataProviderError? = nil
            if case .failure(let error) = result, let error = error as? DataProviderError {
                dataProviderError = error
            }
            let viewCtrlModel = ErrorViewModel(title: title, error: dataProviderError)
            let errorViewController = ErrorViewController(viewModel: viewCtrlModel)
            navigationViewController.viewControllers = [errorViewController]
            return
        }
        let locationsViewController = LocationsCollectionViewController(
            viewModel: LocationListViewModel(title, locations),
            layout: UICollectionViewFlowLayout()
        )
        locationsViewController.delegate = self
        locationUpdateDelegate = locationsViewController
        navigationViewController.viewControllers = [locationsViewController]
    }
    
    private func fetchLocationWithRadius(_ radius: Int) {
        dependency.dataProvider.fetchLocationList(radius, { result in
            DispatchQueue.main.async { [weak self] in
                self?.processUpdateResults(result)
            }
        })
    }
    
    private func processUpdateResults(_ result: DataProvider.FetchLocationResult) {
        guard case .success(let locations) = result, locations.isEmpty == false else {
            var dataProviderError: DataProviderError? = nil
            if case .failure(let error) = result, let error = error as? DataProviderError {
                dataProviderError = error
            }
            let viewCtrlModel = ErrorViewModel(title: title, error: dataProviderError)
            let errorViewController = ErrorViewController(viewModel: viewCtrlModel)
            navigationViewController.present(errorViewController, animated: true)
            return
        }
        locationUpdateDelegate?.didModelUpdated(LocationListViewModel(title, locations))
    }
}

extension HomeCoordinator: LocationCollectionViewDelegate {
    func didChangeRadius(_ radius: Int) {
        fetchLocationWithRadius(radius)
    }
}
