//
//  TMDBProvider.swift
//  MoviesApp
//
//  Created by Omar Yunusov on 09.01.26.
//

final class TMDBAuthProvider: AuthProviding {

    private let token: String

    init(token: String) {
        self.token = token
    }

    var authHeader: String? {
        "Bearer \(token)"
    }
}
