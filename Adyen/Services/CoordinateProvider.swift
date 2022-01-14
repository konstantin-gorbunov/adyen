//
//  CoordinateProvider.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 14/01/2022.
//

import CoreLocation

protocol CoordinateProvider {
    typealias FetchCoordinateResult = Result<Coordinate2D, Error>
    typealias FetchCoordinateCompletion = (FetchCoordinateResult) -> Void
    
    func fetchLocation(_ completion: @escaping FetchCoordinateCompletion)
}
