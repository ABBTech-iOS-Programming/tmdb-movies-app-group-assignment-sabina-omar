//
//  SearchEndpoints.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 03.01.26.
//


import Foundation

enum SearchEndpoints {
    case movie(query: String)
}

extension SearchEndpoints: Endpoint {
    var baseURL: String { Constants.baseURL }

    var path: String { "/search/movie" }

    var method: HttpMethod { .get }

    var headers: [String: String]? {
        [
            "Authorization": "Bearer \(Constants.tmdbToken)",
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .movie(let query):
            return [URLQueryItem(name: "query", value: query)]
        }
    }

    var httpBody: Encodable? { nil }
}
