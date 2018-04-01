//
//  RepositoriesMapper.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/1/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import Foundation

class RepositoriesMapper {
    static func map(response: [String : Any]) -> [RepositoryModel] {
        guard let repositories = response["items"] as? [[String : Any]] else {
            return []
        }

        var models = [RepositoryModel]()
        for repository in repositories {
            let name = repository["name"] as? String
            let description = repository["description"] as? String
            let stars = repository["stargazers_count"] as? Int
            let forks = repository["forks"] as? Int
            let updatedString = repository["updated_at"] as? String
            var updatedDate: Date?
            if let updatedString = updatedString {
                updatedDate = Date.formatDate(string: updatedString)
            }
            let model = RepositoryModel(name: name,
                description: description,
                stars: stars,
                forks: forks,
                updateDate: updatedDate)
            models.append(model)
        }

        return models
    }
}
