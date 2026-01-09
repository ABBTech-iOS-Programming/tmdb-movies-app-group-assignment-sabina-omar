//
//  DetailBuilder.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//

import UIKit

import UIKit

final class DetailBuilder {
    static func build(movieId: Int) -> DetailViewController {
        let networkService = DefaultNetworkService()
        
        let viewModel = DetailViewModel(movieId: movieId, networkService: networkService)
        
        let viewController = DetailViewController()
        
        viewController.viewModel = viewModel
        
        
        return viewController
    }
}
