//
//  HomeCoordinatorTests.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

import XCTest
@testable import adyen

final class HomeCoordinatorTests: XCTestCase {
    
    var dependency: MockDependency?
    var coordinator: HomeCoordinator<MockDependency>?
    
    override func setUp() {
        super.setUp()
        
        let navigation = UINavigationController(rootViewController: UIViewController())
        let localDependency = MockDependency()
        dependency = localDependency
        coordinator = HomeCoordinator(
            dependency: localDependency,
            navigation: navigation
        )
    }
    
    override func tearDown() {
        coordinator = nil
        dependency = nil
        super.tearDown()
    }
    
    func testInit() {
        XCTAssertNotNil(dependency)
        XCTAssertNotNil(coordinator)
    }
    
    func testLoadingScreen() {
        coordinator?.start()
        let firstVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(firstVisible is LoadingViewController)
    }
    
    func testErrorScreenEmptyResult() {
        let expectation = self.expectation(description: "Data Fetched, empty POI array")
        if let mock = (dependency?.dataProvider as? MockDataProvider) {
            mock.onFetch = { completion in
                completion(.success([]))
                DispatchQueue.main.async {
                    expectation.fulfill()
                }
            }
        }
        if let mock = (dependency?.locationProvider as? MockCoordinateProvider) {
            mock.onFetch = { completion in
                completion(.success(Coordinate2D(latitude: 52.370216, longitude: 4.895168)))
            }
        }
        coordinator?.start()
        let firstVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(firstVisible is LoadingViewController)
        wait(for: [expectation], timeout: 1)
        let secondVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(secondVisible is ErrorViewController)
        let viewModel = (secondVisible as? ErrorViewController)?.viewModel
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel?.error == nil)
    }
    
    func testErrorScreenWrongData() {
        let expectation = self.expectation(description: "Data Fetch failed, wrong data")
        if let mock = (dependency?.dataProvider as? MockDataProvider) {
            mock.onFetch = { completion in
                completion(.failure(ProviderError.wrongData))
                DispatchQueue.main.async {
                    expectation.fulfill()
                }
            }
        }
        if let mock = (dependency?.locationProvider as? MockCoordinateProvider) {
            mock.onFetch = { completion in
                completion(.success(Coordinate2D(latitude: 52.370216, longitude: 4.895168)))
            }
        }
        coordinator?.start()
        let firstVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(firstVisible is LoadingViewController)
        wait(for: [expectation], timeout: 1)
        let secondVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(secondVisible is ErrorViewController)
        let viewModel = (secondVisible as? ErrorViewController)?.viewModel
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel?.error == .wrongData)
    }
    
    func testLocationScreen() {
        let expectation = self.expectation(description: "Data Fetched")
        let poi = Poi(name: "Domino's Pizza", phone: nil, brands: nil, categorySet: nil, categories: nil, classifications: nil, url: nil)
        let poistion = GeoBias(lat: 52.37149, lon: 4.53102)
        let location = Location(type: nil, id: nil, score: nil, dist: nil, info: nil, poi: poi, address: nil, position: poistion, viewport: nil, entryPoints: nil, dataSources: nil)
        if let mock = (dependency?.dataProvider as? MockDataProvider) {
            mock.onFetch = { completion in
                completion(.success([location]))
                DispatchQueue.main.async {
                    expectation.fulfill()
                }
            }
        }
        if let mock = (dependency?.locationProvider as? MockCoordinateProvider) {
            mock.onFetch = { completion in
                completion(.success(Coordinate2D(latitude: 52.370216, longitude: 4.895168)))
            }
        }
        coordinator?.start()
        let firstVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(firstVisible is LoadingViewController)
        wait(for: [expectation], timeout: 1)
        let secondVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(secondVisible is LocationsCollectionViewController)
    }
}
