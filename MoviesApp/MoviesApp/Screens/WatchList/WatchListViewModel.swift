//
//  WatchListViewModel.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//


import Foundation

final class WatchListViewModel {
    private(set) var watchlistMovies: [MovieDetail] = []
    
    var onDataUpdated: ((Bool) -> Void)?
    
    func loadData() {
        watchlistMovies = LocalManager.shared.getWatchlist()
        onDataUpdated?(watchlistMovies.isEmpty)
    }
    
    func removeFromWatchlist(at index: Int) {
        let movie = watchlistMovies[index]
        LocalManager.shared.toggleWatchlist(movie: movie)
        watchlistMovies.remove(at: index)
        onDataUpdated?(watchlistMovies.isEmpty)
    }
    
    func movie(at index: Int) -> MovieDetail {
        return watchlistMovies[index]
    }
    
    var numberOfItems: Int {
        return watchlistMovies.count
    }
}
