//
//  AppDependency.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

protocol Dependency {
    var dataProvider: DataProvider { get }
}

final class AppDependency: Dependency {

    let dataProvider: DataProvider = LocationsDataProvider()
}
