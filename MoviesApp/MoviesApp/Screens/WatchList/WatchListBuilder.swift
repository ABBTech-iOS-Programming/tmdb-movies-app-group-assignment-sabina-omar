//
//  WatchListBuilder.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//
 
import UIKit

final class WatchListBuilder {
    static func build() -> WatchListViewController {
        let viewModel = WatchListViewModel()
        let viewController = WatchListViewController(viewModel: viewModel)
        
        return viewController
    }
}
