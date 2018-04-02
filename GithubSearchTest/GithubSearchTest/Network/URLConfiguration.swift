//
//  URLConfiguration.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/1/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import Foundation

enum QueryDomain: String {
    case repositories = "repositories"
    case users = "users"
}

struct URLConfiguration {
    static func searchURLStringWith(queryDomain: QueryDomain, query: String) -> String {
        let baseURL = URLConfiguration().baseURL

        // TODO: test
//        return baseURL + "search/" + "\(queryDomain.rawValue)" + "?q=" + query
        return baseURL + "\(queryDomain.rawValue)/\(query)/repos"
    }

    private let baseURL: String = {
        return "https://api.github.com/"
    }()
}
