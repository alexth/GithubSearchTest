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
        setupSelfSizedCells()
    }

    // MARK: - Action

    fileprivate func requestRepositories(with query: String) {
        NetworkManager.shared.GETRequest(queryDomain: .users, query: query) { [weak self] response, error  in
            if let error = error {
                // TODO: handle error
                print("\n\(error)\n")
            }

            guard let response = response else { return }

            self?.repositories = RepositoriesMapper.map(response: response)
        }
    }

    // MARK: - Utils

    private func setupSelfSizedCells() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
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

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text else {
            return
        }

        requestRepositories(with: searchQuery)
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 1 {
            requestRepositories(with: searchText)
        }
    }
}
