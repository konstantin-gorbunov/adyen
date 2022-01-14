//
//  SystemCoordinateProvider.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 14/01/2022.
//

import CoreLocation

final class SystemCoordinateProvider: NSObject, CoordinateProvider {
    
    private var locationManager: LocationManager
    private var completion: FetchCoordinateCompletion?
    
    init(_ locManager: LocationManager) {
        locationManager = locManager
        super.init()
        locationManager.delegate = self
    }
    
    func fetchLocation(_ completion: @escaping FetchCoordinateCompletion) {
        self.completion = completion
    }
    
    private func requestLocation(_ status: CLAuthorizationStatus) {
        if (status == .notDetermined) {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        locationManager.requestLocation()
    }
}

extension SystemCoordinateProvider: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let coordinate = Coordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            completion?(.success(coordinate))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.failure(ProviderError.locationError(inner: error)))
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        requestLocation(status)
    }
}
