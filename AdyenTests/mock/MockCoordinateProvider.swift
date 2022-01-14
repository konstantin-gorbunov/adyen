//
//  MockCoordinateProvider.swift
//  adyenTests
//
//  Created by Kostiantyn Gorbunov on 14/01/2022.
//

@testable import adyen

final class MockCoordinateProvider: CoordinateProvider {
    var onFetch: ((CoordinateProvider.FetchCoordinateCompletion) -> Void)?
    
    func fetchLocation(_ completion: @escaping CoordinateProvider.FetchCoordinateCompletion) {
        onFetch?(completion)
    }
}
