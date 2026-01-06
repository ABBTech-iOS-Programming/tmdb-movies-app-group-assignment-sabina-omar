//
//  MovieDetailEndpoints.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 03.01.26.
//


import Foundation

enum MovieDetailEndpoints {
    case detail(id: Int)
    case reviews(id: Int)
}

extension MovieDetailEndpoints: Endpoint {
    var baseURL: String { Constants.baseURL }

    var path: String {
        switch self {
        case .detail(let id): return "/3/movie/\(id)"
        case .reviews(let id): return "/3/movie/\(id)/reviews"
        }
    }

    var method: HttpMethod { .get }

    var headers: [String: String]? {
        [
            "Authorization": "Bearer \(Constants.tmdbToken)",
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }

    var queryItems: [URLQueryItem]? { nil }
    var httpBody: Encodable? { nil }
}
