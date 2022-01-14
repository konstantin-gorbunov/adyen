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
    private var lastCoordinate: Coordinate2D?

    init(dependency: T, navigation: UINavigationController) {
        navigationViewController = navigation
        super.init(dependency: dependency)
    }
    
    override func start() {
        super.start()

        let loadingViewController = LoadingViewController(nibName: nil, bundle: nil)
        navigationViewController.viewControllers = [loadingViewController]
        loadingViewController.title = title
        
        dependency.locationProvider.fetchLocation { result in
            DispatchQueue.main.async { [weak self] in
                self?.processLocationResults(result)
            }
        }
    }
    
    private func processLocationResults(_ result: CoordinateProvider.FetchCoordinateResult) {
        guard case .success(let coordinate) = result else {
            var dataProviderError: ProviderError? = nil
            if case .failure(let error) = result, let error = error as? ProviderError {
                dataProviderError = error
            }
            let viewCtrlModel = ErrorViewModel(title: title, error: dataProviderError)
            let errorViewController = ErrorViewController(viewModel: viewCtrlModel)
            navigationViewController.viewControllers = [errorViewController]
            return
        }
        lastCoordinate = coordinate
        fetchLocationList(coordinate)
    }
    
    private func fetchLocationList(_ coordinate: Coordinate2D) {
        dependency.dataProvider.fetchLocationList(coordinate, nil, { result in
            DispatchQueue.main.async { [weak self] in
                self?.processDataResults(result)
            }
        })
    }

    private func processDataResults(_ result: DataProvider.FetchLocationResult) {
        guard case .success(let locations) = result, locations.isEmpty == false else {
            var dataProviderError: ProviderError? = nil
            if case .failure(let error) = result, let error = error as? ProviderError {
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
    
    private func fetchLocationWithRadius(_ coordinate: Coordinate2D?, _ radius: Int) {
        dependency.dataProvider.fetchLocationList(coordinate, radius, { result in
            DispatchQueue.main.async { [weak self] in
                self?.processUpdateDataResults(result)
            }
        })
    }
    
    private func processUpdateDataResults(_ result: DataProvider.FetchLocationResult) {
        guard case .success(let locations) = result, locations.isEmpty == false else {
            var dataProviderError: ProviderError? = nil
            if case .failure(let error) = result, let error = error as? ProviderError {
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
        fetchLocationWithRadius(lastCoordinate, radius)
    }
}
