//
//  NetworkManager.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/1/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
}

extension NetworkManager: APISearch {}

typealias JSONResponse = ([[String : Any]]?, Error?) -> Void

protocol APIJSON {
    func  GETRequest(queryDomain: QueryDomain,
                     query: String,
                     completion: @escaping JSONResponse)
}

extension APIJSON {
    func GETRequest(queryDomain: QueryDomain,
                    query: String,
                    completion: @escaping JSONResponse) {
        let urlSession = URLSession.shared
        urlSession.invalidateAndCancel()

        let request = generalURLRequest(queryDomain: queryDomain, query: query)
        urlSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(nil, error)
                    return
                }
                guard let responseObject = try? JSONSerialization.jsonObject(with: data) else {
                    completion(nil, NetworkError.serializationFailed)
                    return
                }
                guard let responseDictionary = responseObject as? [[String : Any]] else {
                    completion(nil, NetworkError.castIssue)
                    return
                }

                return completion(responseDictionary, nil)
            }
        }.resume()
    }

    // MARK: - Utils

    private func generalURLRequest(queryDomain: QueryDomain, query: String) -> URLRequest {
        let URLString = URLConfiguration.searchURLStringWith(queryDomain: queryDomain, query: query)
        guard let url = URL(string: URLString) else {
            fatalError("ERROR! Unable to build URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "content-type")

        return URLRequest(url: url)
    }
}
