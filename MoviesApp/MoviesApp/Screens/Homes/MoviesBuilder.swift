//
//  MoviesBuilder.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//


class MoviesBuilder {
    static func build() -> MoviesViewController {
        let networkService: NetworkService = DefaultNetworkService()
        let vm = MoviesViewModel(networkService: networkService)
        let vc = MoviesViewController(viewModel: vm)
        return vc
    }
}
