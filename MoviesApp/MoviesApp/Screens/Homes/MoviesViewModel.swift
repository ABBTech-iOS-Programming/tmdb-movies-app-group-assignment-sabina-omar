//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//

import Foundation

final class MoviesViewModel {
    private let networkService: NetworkService
    
    var trendingMovies: [Movie] = []
    var categoryMovies: [Movie] = []
    var currentCategory: MovieCategory = .nowPlaying
    let filterCategories = MovieCategory.filterCategories
    
    var onTrendingMoviesUpdated: () -> Void = {}
    var onCategoryMoviesUpdated: () -> Void = {}
    var onError: (String) -> Void = { _ in }
    private(set) var searchResults: [Movie] = []
    var onSearchResultsUpdated: (() -> Void)?

    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    func fetchMovies(_ category: MovieCategory) {
        networkService.request(category.endpoint) {
            [weak self] (result: Result<MovieResponse, NetworkError>) in
            
            guard let self else { return }
            
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    if category == .trending {
                        self.trendingMovies = response.results
                        self.onTrendingMoviesUpdated()
                    } else {
                        self.currentCategory = category
                        self.categoryMovies = response.results
                        self.onCategoryMoviesUpdated()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let errorMessage = "Failed to fetch \(category.title) movies: \(error.localizedDescription)"
                    print("Movie Not Found", errorMessage)
                    self.onError(errorMessage)
                }
            }
        }
    }
    
    func fetchTrendingMovies() {
        fetchMovies(.trending)
    }
}

enum MovieCategory: CaseIterable {
    case trending, nowPlaying, upcoming, topRated, popular
    
    var endpoint: MoviesEndpoints {
            switch self {
            case .trending:
                return .trending
            case .nowPlaying:
                return .nowPlaying
            case .popular:
                return .popular
            case .upcoming:
                return .upcoming
            case .topRated:
                return .topRated
            }
        }
    
    var title: String {
            switch self {
            case .trending:
                return "Trending"
            case .nowPlaying:
                return "Now Playing"
            case .popular:
                return "Popular"
            case .upcoming:
                return "Upcoming"
            case .topRated:
                return "Top Rated"
            }
        }
    
    static var filterCategories: [MovieCategory] {
          [.nowPlaying, .popular, .upcoming, .topRated]
      }
}


