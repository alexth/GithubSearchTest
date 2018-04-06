//
//  SearchViewController.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/1/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import UIKit
import OAuthSwift

typealias LanguageGroup = (language: String, models: [RepositoryModel])

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    private struct Constants {
        static let repositoryCellIdentifier = "repositoryCell"
    }

    private var repositories: [LanguageGroup] {
        didSet {
            if let tableView = tableView {
                tableView.reloadData()
            }
        }
    }
    private let oauthManager = OAuthManager.shared
    private var oauthSwift: OAuth2Swift?

    // MARK: - View Lifecycle

    required init?(coder aDecoder: NSCoder) {
        repositories = []
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelfSizedCells()
        setupKeyboardDismissMode()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
        checkOAuthSetup()
    }

    // MARK: - Action

    fileprivate func requestRepositories(with query: String) {
        NetworkManager.shared.GETRequest(queryDomain: .users, query: query) { [weak self] response, error  in
            if let error = error {
                // TODO: handle error
                print("\n\(error)\n")
            }

            if let oauthError = error as? OAuthSwiftError {
                switch oauthError {
                case .missingToken:
                    self?.doOAuthGithub()
                default:
                    // TODO: handle all cases
                    print("\(error)")
                }
            }

            // TODO: handle
            guard let response = response else { return }

            self?.repositories = RepositoriesMapper.map(response: response)
        }
    }

    private func doOAuthGithub(){
        oauthManager.authenticateGithub()
    }

    private func checkOAuthSetup() {
        if !oauthManager.isTokenSet {
            doOAuthGithub()
        }
    }
    // MARK: - Utils

    private func setupSelfSizedCells() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
    }

    private func setupKeyboardDismissMode() {
        tableView.keyboardDismissMode = .onDrag
    }
}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories[section].models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.repositoryCellIdentifier, for: indexPath) as? RepositoryCell else {
            fatalError("ERROR! Unable to dequeue RepositoryCell")
        }

        cell.updateWith(model: repositories[indexPath.section].models[indexPath.row])
        cell.color(for: indexPath)

        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("TableHeaderView", owner: self, options: nil)?.first as? TableHeaderView else {
            fatalError("ERROR! Unable to instantiate TableHeaderView")
        }

        let section = repositories[section]
        let headerText = "\(section.language) (\(section.models.count))"
        headerView.updateWith(headerText: headerText)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 26
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
        guard let searchQuery = searchBar.text,
            searchQuery.count > 1 else {
            return
        }

        requestRepositories(with: searchQuery)
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 1 {
            requestRepositories(with: searchText)
        } else {
            repositories = []
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        repositories = []
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
