//
//  MockDependency.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

@testable import adyen

final class MockDependency: Dependency {
    let locationProvider: CoordinateProvider = MockCoordinateProvider()
    let dataProvider: DataProvider = MockDataProvider()
    var locationManager: LocationManager = MockLocationManager()
}
