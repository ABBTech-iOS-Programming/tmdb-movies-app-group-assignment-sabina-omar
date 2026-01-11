//
//  WatchlistEndpoints.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 03.01.26.
//


import Foundation

enum WatchlistEndpoints {
    case getWatchlist(accountId: Int)
    case updateWatchlist(accountId: Int, movieId: Int, isAdding: Bool)
}

extension WatchlistEndpoints: Endpoint {
    var baseURL: String { Constants.baseURL }

    var path: String {
        switch self {
        case .getWatchlist(let accountId):
            return "/3/account/\(accountId)/watchlist/movies"
        case .updateWatchlist(let accountId, _, _):
            return "/3/account/\(accountId)/watchlist"
        }
    }

    var method: HttpMethod {
        switch self {
        case .getWatchlist: return .get
        case .updateWatchlist: return .post
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
        case .updateWatchlist(_, let movieId, let isAdding):
            return AddToWatchlistBody(media_type: "movie", media_id: movieId, watchlist: isAdding)
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
