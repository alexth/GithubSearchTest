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
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        starsLabel.text = "Stars: \(model.stars)"
        forksLabel.text = "fork: \(model.forks)"
        updateDateLabel.text = "updated: \(model.updateDate)"
    }
}