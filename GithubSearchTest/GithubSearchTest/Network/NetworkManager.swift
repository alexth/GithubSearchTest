//
//  NetworkManager.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/1/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import Foundation
import OAuthSwift

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

        let URLString = URLConfiguration.searchURLStringWith(queryDomain: queryDomain, query: query)
        _ = OAuthManager.shared.oauthSwift.client.get(URLString, success: { response in
            guard let responseObject = try? JSONSerialization.jsonObject(with: response.data) else {
                completion(nil, NetworkError.serializationFailed)
                return
            }
            guard let responseDictionary = responseObject as? [[String : Any]] else {
                completion(nil, NetworkError.castIssue)
                return
            }

            return completion(responseDictionary, nil)
        }) { error in
            completion(nil, error)
        }
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
