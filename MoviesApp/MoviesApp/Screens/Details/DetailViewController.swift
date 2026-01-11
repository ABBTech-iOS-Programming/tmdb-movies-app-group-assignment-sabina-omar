//
//  DetailViewController.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//


import UIKit
import SnapKit

final class DetailViewController: CustomViewController {
    
    private var selectedTabIndex: Int = 0
    private var isMovieSaved: Bool = false
    var viewModel: DetailViewModelProtocol?
    private let detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTabs()
        setupDelegates()
        bindViewModel()
        
        viewModel?.fetchMovieDetail()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if selectedTabIndex == 0, let firstButton = detailView.tabButtons.first {
            detailView.setupInitialIndicator(for: firstButton)
        }
    }
}

extension DetailViewController {
    
    private func setupNavBar() {
        UIHelper.configureNavigationBar(for: self, title: "Detail", showBackButton: true)
        
        let bookmarkItem = UIBarButtonItem(
            image: UIImage(systemName: "bookmark"),
            style: .plain,
            target: self,
            action: #selector(bookmarkTapped)
        )
        navigationItem.rightBarButtonItem = bookmarkItem
    }
    
    private func setupTabs() {
        let titles = ["About Movie", "Reviews"]
        for (index, title) in titles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            button.tag = index
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            
            detailView.tabsStack.addArrangedSubview(button)
            detailView.tabButtons.append(button)
        }
    }
}

extension DetailViewController {
    
    private func bindViewModel() {
        viewModel?.didUpdateDetail = { [weak self] detail in
            DispatchQueue.main.async {
                self?.detailView.configureUI(with: detail)
            }
        }
        
        viewModel?.didUpdateReviews = { [weak self] in
            DispatchQueue.main.async { self?.detailView.reviewsTableView.reloadData() }
        }
        
        viewModel?.didUpdateWatchlistStatus = { [weak self] isAdded in
            DispatchQueue.main.async {
                self?.isMovieSaved = isAdded
                let iconName = isAdded ? "bookmark.fill" : "bookmark"
                self?.navigationItem.rightBarButtonItem?.image = UIImage(systemName: iconName)
            }
        }
    }
    
    @objc private func bookmarkTapped() {
        viewModel?.toggleWatchlist(isAdding: !isMovieSaved)
    }
    
    @objc private func tabTapped(_ sender: UIButton) {
        selectedTabIndex = sender.tag
        
        if let titleLabel = sender.titleLabel {
            detailView.indicatorView.snp.remakeConstraints { make in
                make.top.equalTo(detailView.tabsStack.snp.bottom).offset(2)
                make.centerX.equalTo(titleLabel.snp.centerX)
                make.width.equalTo(titleLabel.intrinsicContentSize.width)
                make.height.equalTo(4)
            }
            UIView.animate(withDuration: 0.3) { self.view.layoutIfNeeded() }
        }

        detailView.overviewLabel.isHidden = (sender.tag != 0)
        detailView.reviewsTableView.isHidden = (sender.tag != 1)

        if sender.tag == 1 && (viewModel?.reviews.isEmpty ?? true) {
            viewModel?.fetchReviews()
        }
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func setupDelegates() {
        detailView.reviewsTableView.delegate = self
        detailView.reviewsTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.reviews.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as? ReviewCell else { return UITableViewCell() }
        if let review = viewModel?.reviews[indexPath.row] {
            cell.configure(with: review)
        }
        return cell
    }
}
