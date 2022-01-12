//
//  Location.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

import Foundation

struct SearchResponse: Codable {
    let summary: Summary?
    let results: [Location]?
}

// MARK: - Result
struct Location: Codable {
    let type: String?
    let id: String?
    let score: Double?
    let dist: Double?
    let info: String?
    let poi: Poi?
    let address: Address?
    let position: GeoBias?
    let viewport: Viewport?
    let entryPoints: [EntryPoint]?
    let dataSources: DataSources?
}

// MARK: - Address
struct Address: Codable {
    let streetNumber, streetName, municipality, countrySubdivision: String?
    let postalCode, extendedPostalCode, countryCode, country: String?
    let countryCodeISO3, freeformAddress, localName: String?
}

// MARK: - DataSources
struct DataSources: Codable {
    let poiDetails: [PoiDetail]?
}

// MARK: - PoiDetail
struct PoiDetail: Codable {
    let id, sourceName: String?
}

// MARK: - EntryPoint
struct EntryPoint: Codable {
    let type: String?
    let position: GeoBias?
}

// MARK: - GeoBias
struct GeoBias: Codable {
    let lat, lon: Double
}

// MARK: - Poi
struct Poi: Codable {
    let name, phone: String?
    let brands: [Brand]?
    let categorySet: [CategorySet]?
    let categories: [Query]?
    let classifications: [Classification]?
    let url: String?
}

// MARK: - Brand
struct Brand: Codable {
    let name: String?
}

enum Query: String, Codable {
    case pizza = "pizza"
    case restaurant = "restaurant"
}

// MARK: - CategorySet
struct CategorySet: Codable {
    let id: Int?
}

// MARK: - Classification
struct Classification: Codable {
    let code: String?
    let names: [Name]?
}

// MARK: - Name
struct Name: Codable {
    let nameLocale: NameLocale?
    let name: Query?
}

enum NameLocale: String, Codable {
    case enUS = "en-US"
}

// MARK: - Viewport
struct Viewport: Codable {
    let topLeftPoint, btmRightPoint: GeoBias?
}

// MARK: - Summary
struct Summary: Codable {
    let query: Query?
    let queryType: String?
    let queryTime, numResults, offset, totalResults: Int?
    let fuzzyLevel: Int?
    let geoBias: GeoBias?
}
