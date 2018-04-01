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
    func GETRequest(query: String, completion: @escaping ([String : Any]) -> Void)
}

extension APIJSON {
    func GETRequest(query: String, completion: @escaping ([String : Any]) -> Void) {
        let urlSession = URLSession.shared
        urlSession.invalidateAndCancel()

        let request = generalURLRequest(query: query)
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

    private func generalURLRequest(query: String) -> URLRequest {
        guard let url = URL(string: NetworkConfiguration.URLString(with: query)) else {
            fatalError("ERROR! Unable to build URL")
        }

        return URLRequest(url: url)
    }
}
