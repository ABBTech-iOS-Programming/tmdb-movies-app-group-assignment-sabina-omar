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
    
    func fetchMovieDetail()
    func fetchReviews()
}

final class DetailViewModel: DetailViewModelProtocol {
    private let networkService: NetworkService
    private let movieId: Int
    
    var movieDetail: MovieDetail?
    var reviews: [Review] = []
    
    var didUpdateDetail: ((MovieDetail) -> Void)?
    var didUpdateReviews: (() -> Void)?
    
    init(movieId: Int, networkService: NetworkService = DefaultNetworkService()) {
        self.movieId = movieId
        self.networkService = networkService
    }
    
    func fetchMovieDetail() {
        networkService.request(MovieDetailEndpoints.detail(id: movieId)) { [weak self] (result: Result<MovieDetail, NetworkError>) in
            if case .success(let detail) = result {
                self?.movieDetail = detail
                DispatchQueue.main.async { self?.didUpdateDetail?(detail) }
            }
        }
    }
    
    func fetchReviews() {
        networkService.request(MovieDetailEndpoints.reviews(id: movieId)) { [weak self] (result: Result<ReviewResponse, NetworkError>) in
            if case .success(let response) = result {
                self?.reviews = response.results
                DispatchQueue.main.async { self?.didUpdateReviews?() }
            }
        }
    }
    
}
