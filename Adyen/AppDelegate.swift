//
//  AppDelegate.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var dependency = AppDependency()
    lazy var appCoordinator = AppCoordinator(dependency: dependency)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appCoordinator.start()
        return true
    }
}
