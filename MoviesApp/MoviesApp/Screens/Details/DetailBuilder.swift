//
//  DetailBuilder.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 02.01.26.
//

class DetailBuilder {
    static func build(with movie: MovieDetail) -> DetailViewController {
        let viewModel = DetailViewModel(movieDetail: movie)
        return DetailViewController(viewModel: viewModel)
    }
}
