//
//  SearchViewModel.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//

import Foundation

class SearchViewModel {
    
    private let networkService: NetworkService
      var movies: [Movie] = []

      var onResultsUpdated: (() -> Void)?
      var onError: ((String) -> Void)?

      init(networkService: NetworkService) {
          self.networkService = networkService
      }

      func searchMovies(query: String) {
          guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
              movies = []
              onResultsUpdated?()
              return
          }

          networkService.request(
              SearchEndpoints.movie(query: query)
          ) { [weak self] (result: Result<MovieResponse, NetworkError>) in
              DispatchQueue.main.async {
                  switch result {
                  case .success(let response):
                      self?.movies = response.results
                      self?.onResultsUpdated?()
                  case .failure(let error):
                      self?.onError?(error.localizedDescription)
                  }
              }
          }
      }

      func movie(at index: Int) -> Movie {
          movies[index]
      }

      var numberOfItems: Int {
          movies.count
      }
}
