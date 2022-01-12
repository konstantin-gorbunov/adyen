//
//  LocationsDataProvider.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

import Foundation

struct LocationsDataProvider: DataProvider {
    
    private enum Constants {
        // TODO: use a template to generate a url with search request with variable radius, lat/lon and key as parameters
        static let url: URL? = URL(string: "https://api.tomtom.com/search/2/poiSearch/pizza.json?limit=10")
    }

    func fetchLocationList(_ completion: @escaping FetchLocationCompletion) {
        guard let url = Constants.url else {
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
