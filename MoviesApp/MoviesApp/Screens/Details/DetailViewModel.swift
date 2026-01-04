//
//  DetailViewModel.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 30.12.25.
//


import Foundation

final class DetailViewModel {

    private let networkService: NetworkService
    private let movieId: Int
    private let accountId: Int

    private(set) var movieDetail: MovieDetail?
    private(set) var reviews: [Review] = []

    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?

    init(
        movieId: Int,
        accountId: Int = Constants.accountID,
        networkService: NetworkService = DefaultNetworkService()
    ) {
        self.movieId = movieId
        self.accountId = accountId
        self.networkService = networkService
    }

    func fetchMovieDetail() {
        let endpoint = MovieDetailEndpoints.detail(id: movieId)
        networkService.request(endpoint) { [weak self] (result: Result<MovieDetail, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let detail):
                    self?.movieDetail = detail
                    self?.onDataUpdated?()
                case .failure:
                    self?.onError?("Movie detail yüklənmədi")
                }
            }
        }
    }

    // MARK: - Fetch Reviews
    func fetchReviews() {
        let endpoint = MovieDetailEndpoints.reviews(id: movieId)
        networkService.request(endpoint) { [weak self] (result: Result<ReviewResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.reviews = response.results
                    self?.onDataUpdated?()
                case .failure:
                    self?.onError?("Reviews yüklənmədi")
                }
            }
        }
    }

    // MARK: - Add to Watchlist
    func addToWatchlist() {
        let endpoint = WatchlistEndpoints.addToWatchlist(
            accountId: accountId,
            movieId: movieId
        )

        networkService.request(endpoint) { (_: Result<EmptyResponse, NetworkError>) in
            // success/error handling optional
        }
    }
}

// TMDB POST response üçün boş model
struct EmptyResponse: Decodable {}
