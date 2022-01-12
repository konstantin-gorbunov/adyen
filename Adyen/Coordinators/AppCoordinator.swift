//
//  AppCoordinator.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

import UIKit

/// Main App Coordinator
final class AppCoordinator<T: Dependency>: Coordinator<T>, RootViewProvider {

    lazy var rootViewController: UIViewController = {
        return navigationViewController
    }()

    private let window = UIWindow(frame: UIScreen.main.bounds)
    private(set) lazy var navigationViewController = UINavigationController()

    override func start() {
        let homeCoordinator = HomeCoordinator(
            dependency: dependency,
            navigation: navigationViewController
        )
        add(childCoordinator: homeCoordinator)
        homeCoordinator.start()

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
