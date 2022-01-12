//
//  LocationViewModel.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 12/01/2022.
//

import Foundation

struct LocationViewModel {
    let location: Location?
    let name: String
    let coordinate: String
    
    init(_ location: Location?) {
        self.location = location
        guard let location = location else {
            coordinate = NSLocalizedString("Empty coordinates", comment: "Empty coordinates message")
            name = ""
            return
        }
        if let position = location.position, let dist = location.dist {
            coordinate = "Lat: \(position.lat) Long: \(position.lon) Dist: \(dist.rounded())"
        } else if let position = location.position {
            coordinate = "Lat: \(position.lat) Long: \(position.lon)"
        } else {
            coordinate = NSLocalizedString("Empty coordinates", comment: "Empty coordinates message")
        }
        if let poiName = location.poi?.name {
            name = poiName
        } else {
            name = NSLocalizedString("No name", comment: "Empty name message")
        }
    }
}
