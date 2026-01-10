//
//  LocalManager.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 10.01.26.
//


import Foundation

final class LocalManager {
    static let shared = LocalManager()
    private let key = "watchlist_movies"
    
    func getWatchlist() -> [MovieDetail] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let movies = try? JSONDecoder().decode([MovieDetail].self, from: data) else { return [] }
        return movies
    }
    
    func toggleWatchlist(movie: MovieDetail) {
        var movies = getWatchlist()
        
        if let index = movies.firstIndex(where: { $0.id == movie.id }) {
            movies.remove(at: index)
        } else {
            movies.append(movie)
        }
        
        if let encoded = try? JSONEncoder().encode(movies) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func isSaved(movieId: Int) -> Bool {
        return getWatchlist().contains(where: { $0.id == movieId })
    }
}
