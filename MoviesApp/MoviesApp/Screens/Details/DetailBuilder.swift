//
//  DetailBuilder.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//

import UIKit

final class DetailBuilder {
    static func build(movieId: Int) -> DetailViewController {
        let viewModel = DetailViewModel(movieId: movieId)
        let viewController = DetailViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
