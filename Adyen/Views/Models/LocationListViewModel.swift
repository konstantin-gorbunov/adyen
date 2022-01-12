//
//  LocationListViewModel.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 12/01/2022.
//

struct LocationListViewModel {
    let title: String
    /// List of Locations
    let locations: [Location]
    
    init(_ title: String, _ locations: [Location]) {
        self.title = title
        self.locations = locations
    }
}
