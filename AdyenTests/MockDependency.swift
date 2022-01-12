//
//  MockDependency.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

final class MockDataProvider: DataProvider {

    var onFetch: ((DataProvider.FetchLocationCompletion) -> Void)?

    func fetchLocationList(_ radius: Int?, _ completion: @escaping DataProvider.FetchLocationCompletion) {
        onFetch?(completion)
    }
}

final class MockDependency: Dependency {

    let dataProvider: DataProvider = MockDataProvider()
}
