//
//  WatchListViewModel.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//


import Foundation

final class WatchListViewModel {
    private let networkService: NetworkService
    private(set) var watchlistMovies: [Movie] = []
    
    var onDataUpdated: ((Bool) -> Void)?
    
    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }
    
    func loadData() {
        networkService.request(WatchlistEndpoints.getWatchlist(accountId: Constants.accountID)) { [weak self] (result: Result<MovieResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.watchlistMovies = response.results
                    self?.onDataUpdated?(self?.watchlistMovies.isEmpty ?? true)
                case .failure:
                    self?.watchlistMovies = []
                    self?.onDataUpdated?(true)
                }
            }
        }
    }
    
    func removeFromWatchlist(at index: Int) {
        let movie = watchlistMovies[index]
        let endpoint = WatchlistEndpoints.updateWatchlist(
            accountId: Constants.accountID,
            movieId: movie.id,
            isAdding: false
        )
        
        networkService.request(endpoint) { [weak self] (result: Result<GeneralResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.watchlistMovies.remove(at: index)
                    self?.onDataUpdated?(self?.watchlistMovies.isEmpty ?? true)
                case .failure(let error):
                    print("Failed to remove: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func movie(at index: Int) -> Movie {
        return watchlistMovies[index]
    }
    
    var numberOfItems: Int {
        return watchlistMovies.count
    }
}
