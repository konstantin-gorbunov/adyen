//
//  AppDependency.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

import CoreLocation

protocol Dependency {
    var dataProvider: DataProvider { get }
    var locationProvider: CoordinateProvider { get }
    var locationManager: LocationManager { get }
}

final class AppDependency: Dependency {
    let locationManager: LocationManager = CLLocationManager()
    let dataProvider: DataProvider = LocationsDataProvider()
    let locationProvider: CoordinateProvider
    
    init() {
        locationProvider = SystemCoordinateProvider(locationManager)
    }
}
