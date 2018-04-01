//
//  APISearch.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/1/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import Foundation

protocol APISearch: APIJSON {
    func search(queryDomain: QueryDomain, query: String, completion: @escaping JSONResponse)
}

extension APISearch {
    func search(queryDomain: QueryDomain, query: String, completion: @escaping JSONResponse) {
        return GETRequest(queryDomain: queryDomain, query: query, completion: completion)
    }
}
