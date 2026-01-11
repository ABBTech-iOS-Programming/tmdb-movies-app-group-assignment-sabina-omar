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
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        return tableView
    }()
    
    private func addSubview() {
        view.addSubview(searchBar)
        view.addSubview(emptyStateView)
        view.addSubview(tableView)
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
        UIHelper.configureNavigationBar(for: self, title: "Search", showBackButton: true)
        addSubview()
        setupConstraints()
        emptyStateView.configure(
            image: UIImage(named: "MagnifyingGlass"),
            title: "We Are Sorry, We Can Not Find The Movie :(",
            subtitle: "Find your movie by type title, categories, years, etc"
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        
   
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyStateView.isHidden = false
        tableView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel() // UPDATED: remove duplicate call
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
        viewModel.onResultsUpdated = { [weak self] in
            guard let self = self else { return }

            DispatchQueue.main.async {
                let hasResults = !self.viewModel.movies.isEmpty

                self.tableView.isHidden = !hasResults
                self.emptyStateView.isHidden = hasResults

                self.tableView.reloadData()
            }
        }

        viewModel.onError = { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.isHidden = true
                self?.emptyStateView.isHidden = false
            }
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        let trimmed = searchText.trimmingCharacters(in: .whitespaces)
        if trimmed.isEmpty {
            viewModel.searchMovies(query: "")
            tableView.isHidden = true
            emptyStateView.isHidden = false
            return
        }

        viewModel.searchMovies(query: trimmed)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(
            _ tableView: UITableView,
            cellForRowAt indexPath: IndexPath
        ) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieCell.identifier,
                for: indexPath
            ) as! MovieCell

            let movie = viewModel.movie(at: indexPath.row)
            cell.configure(with: movie)
            cell.selectionStyle = .none
            return cell
        }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = viewModel.movie(at: indexPath.row)
    
        let detailVC = DetailBuilder.build(movieId: movie.id)
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

