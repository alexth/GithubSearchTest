//
//  RepositoryModel.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/1/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import Foundation

struct RepositoryModel {
    let name: String?
    let description: String?
    let stars: Int?
    let forks: Int?
    let updateDate: Date?

    init(name: String?,
         description: String?,
         stars: Int?,
         forks: Int?,
         updateDate: Date?) {
        self.name = name
        self.description = description
        self.stars = stars
        self.forks = forks
        self.updateDate = updateDate
    }
}
