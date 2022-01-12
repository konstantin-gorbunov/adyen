//
//  URLSession.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

import Foundation

// MARK: - URLSession response handlers

extension URLSession {
    private func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            completionHandler(try? decoder.decode(T.self, from: data), response, nil)
        }
    }

    func searchResponseTask(with url: URL, completionHandler: @escaping (SearchResponse?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return codableTask(with: url, completionHandler: completionHandler)
    }
}
