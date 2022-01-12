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
    private var locations: [Location] = []

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
        self.locations = locations
        let locationsViewController = LocationsCollectionViewController(
            viewModel: LocationListViewModel(title, locations),
            layout: UICollectionViewFlowLayout()
        )
        navigationViewController.viewControllers = [locationsViewController]
    }
}
