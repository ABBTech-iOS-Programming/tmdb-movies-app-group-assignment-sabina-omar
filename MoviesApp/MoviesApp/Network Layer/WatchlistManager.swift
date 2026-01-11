//
//  WatchlistManager.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 10.01.26.
//


import Foundation

final class WatchlistManager {
    static let shared = WatchlistManager()
    private let networkService = DefaultNetworkService()
    private(set) var savedMovieIds: Set<Int> = []
    
    private init() {}
    
    func fetchWatchlist(completion: (() -> Void)? = nil) {
        networkService.request(WatchlistEndpoints.getWatchlist(accountId: Constants.accountID)) { [weak self] (result: Result<MovieResponse, NetworkError>) in
            if case .success(let response) = result {
                self?.savedMovieIds = Set(response.results.map { $0.id })
                completion?()
            }
        }
    }
    
    func isMovieSaved(id: Int) -> Bool {
        return savedMovieIds.contains(id)
    }
    
    func updateStatus(movieId: Int, isSaved: Bool) {
        if isSaved {
            savedMovieIds.insert(movieId)
        } else {
            savedMovieIds.remove(movieId)
        }
    }
}
