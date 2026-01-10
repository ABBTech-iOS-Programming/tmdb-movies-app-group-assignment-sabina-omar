//
//  SearchBuilder.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//

class SearchBuilder {
    static func build() -> SearchViewController {
        let networkService: NetworkService = DefaultNetworkService()
        let vm = SearchViewModel(networkService: networkService)
        let vc = SearchViewController(viewModel: vm)
        return vc
    }
}
