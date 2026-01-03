//
//  WatchlistEndpoints.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 03.01.26.
//


import Foundation

enum WatchlistEndpoints {
    case getWatchlist(accountId: Int)
    case addToWatchlist(accountId: Int, movieId: Int)
}

extension WatchlistEndpoints: Endpoint {
    var baseURL: String { Constants.baseURL }

    var path: String {
        switch self {
        case .getWatchlist(let accountId):
            return "/account/\(accountId)/watchlist/movies"
        case .addToWatchlist(let accountId, _):
            return "/account/\(accountId)/watchlist"
        }
    }

    var method: HttpMethod {
        switch self {
        case .getWatchlist: return .get
        case .addToWatchlist: return .post
        }
    }

    var headers: [String: String]? {
        [
            "Authorization": "Bearer \(Constants.tmdbToken)",
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }

    var queryItems: [URLQueryItem]? { nil }

    var httpBody: Encodable? {
        switch self {
        case .addToWatchlist(_, let movieId):
            return AddToWatchlistBody(media_type: "movie", media_id: movieId, watchlist: true)
        default:
            return nil
        }
    }
}

struct AddToWatchlistBody: Encodable {
    let media_type: String
    let media_id: Int
    let watchlist: Bool
}
