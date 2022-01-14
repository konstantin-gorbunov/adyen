//
//  LocationManager.swift
//  adyenTests
//
//  Created by Kostiantyn Gorbunov on 14/01/2022.
//

import CoreLocation

protocol LocationManager {
    var delegate: CLLocationManagerDelegate? { get set }

    func requestLocation()
    func requestWhenInUseAuthorization()
}
