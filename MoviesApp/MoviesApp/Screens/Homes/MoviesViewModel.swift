//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//

import Foundation

protocol MoviesViewModelProtocol {
    
    var trending: [Movie] { get }
    var movies: [Movie] { get }
    
    var onUpdate: (() -> Void)? { get set }
    
    func loadInitialData()
    func selectCategory(_ category: MovieCategory)
}

final class MoviesViewModel: MoviesViewModelProtocol {

    private let networkService: NetworkService
    
    var trending: [Movie] = []
    var movies: [Movie] = []

    var onUpdate: (() -> Void)?

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func loadInitialData() {
        fetchTrending()
        selectCategory(.nowPlaying)
    }
    
    func selectCategory(_ category: MovieCategory) {
        let endpoint: MoviesEndpoints

        switch category {
        case .nowPlaying:
            endpoint = .nowPlaying
        case .popular:
            endpoint = .popular
        case .upcoming:
            endpoint = .upcoming
        case .topRated:
            endpoint = .topRated
        }
        
        fetchMovies(endpoint: endpoint)
    }

    // MARK: - Private Methods
    
    private func fetchTrending() {
        networkService.request(MoviesEndpoints.trending) { [weak self]
            (result: Result<MovieResponse, NetworkError>) in
            guard let self else { return }

            if case let .success(response) = result {
                self.trending = response.results
                self.onUpdate?()
            }
        }
    }
    
    private func fetchMovies(endpoint: MoviesEndpoints) {
        networkService.request(endpoint) { [weak self]
            (result: Result<MovieResponse, NetworkError>) in
            guard let self else { return }

            switch result {
            case .success(let response):
                self.movies = response.results
                self.onUpdate?()

            case .failure(let error):
                print("Movies error:", error)
            }
        }
    }
}

enum MovieCategory: CaseIterable {
    case nowPlaying, upcoming, topRated, popular
}

