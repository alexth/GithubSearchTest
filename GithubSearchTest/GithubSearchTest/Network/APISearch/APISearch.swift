//
//  APISearch.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/1/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import Foundation

protocol APISearch: APIJSON {
    func search(withQuery query: String) -> [String : Any]
}

extension APISearch {
    func search(withQuery query: String) -> [String : Any] {
        return GETRequest(query: query)
    }
}
