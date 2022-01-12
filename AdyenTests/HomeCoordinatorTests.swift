//
//  HomeCoordinatorTests.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

import XCTest
@testable import adyen

class HomeCoordinatorTests: XCTestCase {
    
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
                completion(.failure(DataProviderError.wrongData))
                DispatchQueue.main.async {
                    expectation.fulfill()
                }
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
}
