//
//  MockLocationManager.swift
//  adyenTests
//
//  Created by Kostiantyn Gorbunov on 14/01/2022.
//

import CoreLocation
@testable import adyen

final class MockLocationManager: LocationManager {

    var delegate: CLLocationManagerDelegate?

    func requestLocation() {}
    func requestWhenInUseAuthorization() {}
}
