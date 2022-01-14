//
//  MockDataProvider.swift
//  adyenTests
//
//  Created by Kostiantyn Gorbunov on 14/01/2022.
//

@testable import adyen

final class MockDataProvider: DataProvider {

    var onFetch: ((DataProvider.FetchLocationCompletion) -> Void)?

    func fetchLocationList(_ coordinate: Coordinate2D?, _ radius: Int?, _ completion: @escaping DataProvider.FetchLocationCompletion) {
        onFetch?(completion)
    }
}
