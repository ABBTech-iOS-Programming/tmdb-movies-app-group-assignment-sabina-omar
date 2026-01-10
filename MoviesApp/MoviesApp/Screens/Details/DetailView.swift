//
//  DetailView.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 05.01.26.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailView: UIView {
    var tabButtons: [UIButton] = []

    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .clear
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()

    let backdropImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let movieHeader = MovieHeaderView()
    let ratingBadge = RatingBadgeView()
    
    let tabsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 40
        return stackView
    }()
    
    let indicatorView = AppIndicatorView()
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let reviewsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 120
        tableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.identifier)
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        [overviewLabel, reviewsTableView].forEach(contentStackView.addArrangedSubview)
        
        backdropImage.addSubview(ratingBadge)
        [backdropImage, movieHeader, tabsStack, indicatorView, contentStackView].forEach(contentView.addSubview)
        
        scrollView.addSubview(contentView)
        addSubview(scrollView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        backdropImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(211)
        }
        
        ratingBadge.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(12)
            make.height.equalTo(24)
        }
        
        movieHeader.applyDetailLayout()
        movieHeader.snp.makeConstraints { make in
            make.top.equalTo(backdropImage.snp.bottom).offset(-60)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        tabsStack.snp.makeConstraints { make in
            make.top.equalTo(movieHeader.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(24)
        }
        
        indicatorView.snp.makeConstraints { make in
            make.top.equalTo(tabsStack.snp.bottom).offset(2)
            make.height.equalTo(4)
            make.width.equalTo(0)
            make.centerX.equalTo(tabsStack.snp.leading)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(tabsStack.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        reviewsTableView.snp.makeConstraints { make in
            make.height.equalTo(400)
        }
    }
    
    func setupInitialIndicator(for button: UIButton) {
        guard let titleLabel = button.titleLabel else { return }
        indicatorView.snp.remakeConstraints { make in
            make.top.equalTo(tabsStack.snp.bottom).offset(2)
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.width.equalTo(titleLabel.intrinsicContentSize.width)
            make.height.equalTo(4)
        }
    }

    func configureUI(with detail: MovieDetail) {
        movieHeader.configure(
            title: detail.title,
            year: String(detail.releaseDate?.prefix(4) ?? ""),
            duration: "\(detail.runtime ?? 0) Minutes",
            genre: detail.genres.first?.name ?? "N/A",
            rating: detail.voteAverage,
            posterPath: detail.posterPath
        )
        
        ratingBadge.configure(with: detail.voteAverage)
        
        overviewLabel.text = detail.overview
        
        if let bPath = detail.backdropPath {
            backdropImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(bPath)"))
        }
    }
}
