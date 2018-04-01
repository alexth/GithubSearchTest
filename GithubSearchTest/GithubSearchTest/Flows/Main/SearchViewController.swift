//
//  SearchViewController.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/1/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    private struct Constants {
        static let repositoryCellIdentifier = "repositoryCell"
    }

    private var repositories: [RepositoryModel] {
        didSet {
            if let tableView = tableView {
                tableView.reloadData()
            }
        }
    }

    // MARK: - View Lifecycle

    required init?(coder aDecoder: NSCoder) {
        repositories = []
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.repositoryCellIdentifier, for: indexPath) as? RepositoryCell else {
            fatalError("ERROR! Unable to dequeue RepositoryCell")
        }

        cell.updateWith(model: repositories[indexPath.row])

        return cell
    }
}
