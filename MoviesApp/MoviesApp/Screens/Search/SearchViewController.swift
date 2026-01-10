//
//  SearchViewController.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 30.12.25.
//

import UIKit
import SnapKit

class SearchViewController: CustomViewController {
    
    private var viewModel = SearchViewModel(networkService:DefaultNetworkService())
    
    private let emptyStateView = EmptyStateView()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search"
        search.searchBarStyle = .minimal
        search.backgroundImage = UIImage()
        search.tintColor = UIColor.white.withAlphaComponent(0.6)
        let textField = search.searchTextField
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 16)
        textField.layer.cornerRadius = 16
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [
                .foregroundColor: UIColor.white.withAlphaComponent(0.5)
            ]
        )
        if let glassIcon = textField.leftView as? UIImageView {
            glassIcon.tintColor = UIColor.white.withAlphaComponent(0.6)
        }
        
        return search
    }()
    
    private func addSubview() {
        view.addSubview(searchBar)
        view.addSubview(emptyStateView)
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.horizontalEdges.equalToSuperview().inset(22)
            make.height.equalTo(50)
        }
        
        emptyStateView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setupUI() {
        addSubview()
        setupConstraints()
        emptyStateView.configure(
            image: UIImage(named: "MagnifyingGlass"),
            title: "We Are Sorry, We Can Not Find The Movie :(",
            subtitle: "Find your movie by type title, categories, years, etc"
        )
        emptyStateView.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        searchBar.delegate = self
    }
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindViewModel() {
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           viewModel.searchMovies(query: searchText)
       }

       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           searchBar.resignFirstResponder()
       }
}
