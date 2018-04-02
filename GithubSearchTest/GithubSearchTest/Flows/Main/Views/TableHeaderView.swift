//
//  TableHeaderView.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/2/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import UIKit

class TableHeaderView: UIView {
    @IBOutlet weak var headerLabel: UILabel!

    func updateWith(headerText: String) {
        headerLabel.text = headerText
    }
}
