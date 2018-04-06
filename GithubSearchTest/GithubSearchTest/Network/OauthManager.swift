//
//  OAuthManager.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/6/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import Foundation
import OAuthSwift

class OAuthManager {
    static let shared = OAuthManager()
    private init() {}

    let oauthSwift = OAuth2Swift(
        consumerKey:    "785a237c63e910951d03",
        consumerSecret: "19d5ccee384747ae27cc391462dd6bb62e79c7be",
        authorizeUrl:   "https://github.com/login/oauth/authorize",
        accessTokenUrl: "https://github.com/login/oauth/access_token",
        responseType:   "code"
    )

    var isTokenSet: Bool {
        return oauthSwift.client.credential.oauthToken.count > 0
    }

    func authenticateGithub() {
        let state = generateState(withLength: 20)
        let _ = oauthSwift.authorize(
            withCallbackURL: URL(string: "oauth-callback://host/")!,
            scope: "repo",
            state: state,
            success: { credential, response, parameters in
                // TODO: no need to store credentials, they are added to client automatically
                print("\n\(credential.oauthToken)\n")
        },
            failure: { error in
                // TODO: handle
                print(error.description)
        })
    }
}
