//
//  DetailViewModel.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//

import Foundation

protocol DetailViewModelProtocol {
    var movieDetail: MovieDetail? { get }
    var reviews: [Review] { get }
    var didUpdateDetail: ((MovieDetail) -> Void)? { get set }
    var didUpdateReviews: (() -> Void)? { get set }
    var didUpdateWatchlistStatus: ((Bool) -> Void)? { get set }
    
    func fetchMovieDetail()
    func fetchReviews()
    func toggleWatchlist(isAdding: Bool)
}

final class DetailViewModel: DetailViewModelProtocol {
    private let networkService: NetworkService
    private let movieId: Int
    
    var movieDetail: MovieDetail?
    var reviews: [Review] = []
    
    var didUpdateDetail: ((MovieDetail) -> Void)?
    var didUpdateReviews: (() -> Void)?
    var didUpdateWatchlistStatus: ((Bool) -> Void)?
    
    init(movieId: Int, networkService: NetworkService = DefaultNetworkService()) {
        self.movieId = movieId
        self.networkService = networkService
    }
    
    func fetchMovieDetail() {
        networkService.request(MovieDetailEndpoints.detail(id: movieId)) { [weak self] (result: Result<MovieDetail, NetworkError>) in
            if case .success(let detail) = result {
                self?.movieDetail = detail
                DispatchQueue.main.async {
                    self?.didUpdateDetail?(detail)
                    self?.checkIfSaved()
                }
            }
        }
    }
    
    private func checkIfSaved() {
        networkService.request(WatchlistEndpoints.getWatchlist(accountId: Constants.accountID)) { [weak self] (result: Result<MovieResponse, NetworkError>) in
            guard let self = self else { return }
            if case .success(let response) = result {
                let isSaved = response.results.contains(where: { $0.id == self.movieId })
                DispatchQueue.main.async {
                    self.didUpdateWatchlistStatus?(isSaved)
                }
            }
        }
    }
    
    func fetchReviews() {
        networkService.request(MovieDetailEndpoints.reviews(id: movieId)) { [weak self] (result: Result<ReviewResponse, NetworkError>) in
            if case .success(let response) = result {
                self?.reviews = response.results
                DispatchQueue.main.async {
                    self?.didUpdateReviews?()
                }
            }
        }
    }
    
    func toggleWatchlist(isAdding: Bool) {
        let endpoint = WatchlistEndpoints.updateWatchlist(
            accountId: Constants.accountID,
            movieId: movieId,
            isAdding: isAdding
        )
        
        networkService.request(endpoint) { [weak self] (result: Result<GeneralResponse, NetworkError>) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.didUpdateWatchlistStatus?(isAdding)
                }
            case .failure(let error):
                print("Watchlist error: \(error.localizedDescription)")
            }
        }
    }
}

struct GeneralResponse: Decodable {
    let success: Bool?
    let statusCode: Int?
    let statusMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
