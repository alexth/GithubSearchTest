//
//  RepositoriesMapper.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/1/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import Foundation

class RepositoriesMapper {
    static func map(response: [[String : Any]]) -> [LanguageGroup] {
        var models = [RepositoryModel]()

        for repository in response {
            let name = repository["name"] as? String
            let description = repository["description"] as? String
            let stars = repository["stargazers_count"] as? Int
            let forks = repository["forks"] as? Int
            let updatedString = repository["updated_at"] as? String
            let language = repository["language"] as? String
            var updatedDate: Date?
            if let updatedString = updatedString {
                updatedDate = Date.formatISO8601Date(string: updatedString)
            }

            let model = RepositoryModel(name: name,
                description: description,
                language: language,
                stars: stars,
                forks: forks,
                updateDate: updatedDate)
            models.append(model)
        }

        return RepositoriesMapper().sortByLanguage(models: models)
    }

    // MARK: - Util

    private func sortByLanguage(models: [RepositoryModel]) -> [LanguageGroup] {
        var groups = [LanguageGroup]()

        let languages = Set(models.compactMap { $0.language })
        for language in languages {
            let languageModels = models.filter { $0.language == language }
            let starsFilteredModels = languageModels.sorted { ($0.stars ?? 0) > ($1.stars ?? 0) }
            let group: LanguageGroup = (language, starsFilteredModels)
            groups.append(group)
        }
        groups = groups.sorted { $0.models.count > $1.models.count }

        return groups
    }
}
