//
//  WatchListViewController.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 30.12.25.
//

import UIKit
import SnapKit

class WatchListViewController: CustomViewController {

    private let emptyStateView = EmptyStateView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(emptyStateView)
        emptyStateView.configure(
            image: UIImage(named: "EmptyBox"),
            title: "There Is No Movie Yet!",
            subtitle: "Find your movie by type title, categories, years, etc"
        )
        
        emptyStateView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    
    

    
}
