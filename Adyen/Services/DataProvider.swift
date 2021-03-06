//
//  DataProvider.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

import Foundation

enum ProviderError: Error {
    case wrongApiKey
    case wrongURL
    case wrongData
    case parsingFailure(inner: Error)
    case locationError(inner: Error)
}

extension ProviderError: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch(lhs, rhs) {
        case(.wrongURL, .wrongURL):
            return true
        case(.wrongData, .wrongData):
            return true
        case(.parsingFailure(let lhsError), .parsingFailure(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

protocol DataProvider {
    typealias FetchLocationResult = Result<[Location], Error>
    typealias FetchLocationCompletion = (FetchLocationResult) -> Void

    func fetchLocationList(_ coordinate: Coordinate2D?, _ radius: Int?, _ completion: @escaping FetchLocationCompletion)
}
