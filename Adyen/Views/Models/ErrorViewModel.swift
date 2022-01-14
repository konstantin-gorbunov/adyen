//
//  ErrorViewModel.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

import Foundation

struct ErrorViewModel {

    let title: String
    let error: ProviderError?
    
    var message: String? {
        if let error = error {
            switch error {
            case .wrongApiKey:
                return NSLocalizedString("Wrong API key", comment: "Wrong API key error message")
            case .wrongURL:
                return NSLocalizedString("Wrong URL, can't load data", comment: "Wrong URL error message")
            case .wrongData:
                return NSLocalizedString("Wrong data format, can't load data", comment: "Loadin data error message")
            case .parsingFailure(let inner):
                return String.localizedStringWithFormat(NSLocalizedString("Parsing failure %@", comment: "Parsing failure error message"), inner.localizedDescription)
            case .locationError(let inner):
                return String.localizedStringWithFormat(NSLocalizedString("Location error %@", comment: "Location determination problem"), inner.localizedDescription)
            }
        }
        return NSLocalizedString("Empty search result", comment: "Empty search result message")
    }
}
