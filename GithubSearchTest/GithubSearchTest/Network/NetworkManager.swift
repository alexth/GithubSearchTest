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

protocol APIJSON {
    func  GETRequest(queryDomain: QueryDomain,
                     query: String,
                     completion: @escaping ([String : Any]) -> Void)
}

extension APIJSON {
    func GETRequest(queryDomain: QueryDomain,
                    query: String,
                    completion: @escaping ([String : Any]) -> Void) {
        let urlSession = URLSession.shared
        urlSession.invalidateAndCancel()

        let request = generalURLRequest(queryDomain: queryDomain, query: query)
        urlSession.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // TODO: handle errors
                return
            }
            guard let responseObject = try? JSONSerialization.jsonObject(with: data) else {
                // TODO: handle errors
                fatalError("ERROR! Unable to deserialize web response")
            }
            guard let responseDictionary = responseObject as? [String : Any] else {
                // TODO: handle errors
                fatalError("ERROR! Unable to cast web response")
            }

            return completion(responseDictionary)
        }.resume()
    }

    // MARK: - Utils

    private func generalURLRequest(queryDomain: QueryDomain, query: String) -> URLRequest {
        let URLString = URLConfiguration.searchURLStringWith(queryDomain: queryDomain, query: query)
        guard let url = URL(string: URLString) else {
            fatalError("ERROR! Unable to build URL")
        }

        print("\n\(URLString)\n")

        return URLRequest(url: url)
    }
}
