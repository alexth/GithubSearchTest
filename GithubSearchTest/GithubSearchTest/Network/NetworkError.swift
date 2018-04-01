//
//  NetworkError.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/1/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case notAvailable
    case serializationFailed
    case castIssue

    internal var title: String {
        switch self {
        case .notAvailable:
            return "ERROR! Network is not available"
        case .serializationFailed:
            return "ERROR! Unable to deserialize web response"
        case .castIssue:
            return "ERROR! Unable to cast to dictionary"
        }
    }
}
