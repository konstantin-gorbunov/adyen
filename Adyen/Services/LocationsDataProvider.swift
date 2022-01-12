//
//  LocationsDataProvider.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

import Foundation

struct LocationsDataProvider: DataProvider {
    
    private enum Constants {
        // TODO: add a support of variable radius, lat/lon as parameters
        static let urlTemplate = "https://api.tomtom.com/search/2/poiSearch/pizza.json?limit=10&view=Unified&relatedPois=off&key=%@"
        static let radiusTemplate = "&radius=%d"
    }
    
    private var apiKey: String? {
        get {
            guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
                return nil
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                return nil
            }
            return value
        }
    }

    func fetchLocationList(_ radius: Int?, _ completion: @escaping FetchLocationCompletion) {
        guard let apiKey = apiKey else {
            DispatchQueue.main.async {
                completion(.failure(DataProviderError.wrongApiKey))
            }
            return
        }
        var strUrl = String(format: Constants.urlTemplate, apiKey)
        if let radius = radius {
            strUrl = strUrl + String(format: Constants.radiusTemplate, radius)
        }
        guard let url = URL(string: strUrl) else {
            DispatchQueue.main.async {
                completion(.failure(DataProviderError.wrongURL))
            }
            return
        }
        let task = URLSession.shared.searchResponseTask(with: url) { searchResult, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(DataProviderError.parsingFailure(inner: error)))
                }
            }
            if let result = searchResult?.results {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(DataProviderError.wrongData))
                }
            }
        }
        task.resume()
    }
}
