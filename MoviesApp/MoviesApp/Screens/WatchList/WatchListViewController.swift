//
//  WatchListViewController.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 30.12.25.
//

import UIKit
import SnapKit

final class WatchListViewController: CustomViewController {
    
    var viewModel: WatchListViewModel
    
    init(viewModel: WatchListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private let emptyStateView = EmptyStateView()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] isEmpty in
            DispatchQueue.main.async {
                self?.emptyStateView.isHidden = !isEmpty
                self?.tableView.isHidden = isEmpty
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupUI() {
        UIHelper.configureNavigationBar(for: self, title: "Watch list", showBackButton: true)
        view.addSubview(tableView)
        view.addSubview(emptyStateView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyStateView.configure(
            image: UIImage(named: "EmptyBox"),
            title: "There Is No Movie Yet!",
            subtitle: "Find your movie by type title, categories, years, etc"
        )
        
        emptyStateView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
        }
    }
}

// MARK: - TableView Methods
extension WatchListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        let movie = viewModel.movie(at: indexPath.row)
        cell.configure(with: movie)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            self?.showDeleteAlert(for: indexPath, completionHandler: completionHandler)
        }
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func showDeleteAlert(for indexPath: IndexPath, completionHandler: @escaping (Bool) -> Void) {
        let movieTitle = viewModel.movie(at: indexPath.row).title
        
        let alert = UIAlertController(
            title: "Delete Movie",
            message: "Are you sure you want to remove '\(movieTitle)' from your watchlist?",
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.viewModel.removeFromWatchlist(at: indexPath.row)
            completionHandler(true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completionHandler(false)
        }
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
