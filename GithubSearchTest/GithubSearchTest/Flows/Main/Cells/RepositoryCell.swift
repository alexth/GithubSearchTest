//
//  RepositoryCell.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/1/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!

    func updateWith(model: RepositoryModel) {
        if let name = model.name {
            nameLabel.text = name
        }
        if let description = model.description {
            descriptionLabel.text = description
        }
        if let stars = model.stars {
            starsLabel.text = "Stars: \(stars)"
        }
        if let forks = model.forks {
            forksLabel.text = "fork: \(forks)"
        }
        if let updateDate = model.updateDate {
            let dateString = Date.format(date: updateDate)
            updateDateLabel.text = "updated: \(dateString)"
        }
    }
}
