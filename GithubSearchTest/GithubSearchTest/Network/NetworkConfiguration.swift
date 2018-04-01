//
//  NetworkConfiguration.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/1/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import Foundation

struct NetworkConfiguration {
    static func URLString(with query: String) -> String {
        let baseString = NetworkConfiguration().baseURL
        return "\(baseString)\(query)"
    }

    private let baseURL: String = {
        return "https://api.github.com"
    }()
}
