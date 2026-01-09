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
    
    let ratingContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(named: "ratingView")
        view.clipsToBounds = true
        return view
    }()

    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }()
    
    private let starIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: "star"))
        icon.tintColor = UIColor(named: "ratingLabel")
        return icon
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "ratingLabel")
        label.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        return label
    }()
    
    let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 18)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var yearItem = createInfoItem(iconName: "calendar")
    private lazy var durationItem = createInfoItem(iconName: "clock")
    private lazy var genreItem = createInfoItem(iconName: "ticket")
    
    private let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    let tabsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 40
        return stackView
    }()
    
    let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "indicatorView")
        return view
    }()
    
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
        scrollView.backgroundColor = .clear
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        [
            overviewLabel,
            reviewsTableView
        ].forEach(contentStackView.addArrangedSubview)
        
        
        [
            blurEffectView,
            starIcon,
            ratingLabel
        ].forEach(ratingContainer.addSubview)
            
        backdropImage.addSubview(ratingContainer)
       
        
        [
            yearItem.0,
            createSeparator(),
            durationItem.0,
            createSeparator(),
            genreItem.0
        ].forEach(infoStack.addArrangedSubview)
        
        [backdropImage, posterImage, titleLabel, infoStack, tabsStack, indicatorView, contentStackView].forEach(contentView.addSubview)
        
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
            make.width.equalTo(375)
        }
        
        ratingContainer.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(12)
            make.height.equalTo(24)
        }
            
        blurEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
            
        starIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(16)
        }
            
        ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(starIcon.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
        posterImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(backdropImage.snp.bottom).offset(-60)
            make.width.equalTo(95)
            make.height.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(24)
            make.top.equalTo(backdropImage.snp.bottom).offset(12)
        }
        
        infoStack.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(40)
        }
        
        tabsStack.snp.makeConstraints { make in
            make.top.equalTo(infoStack.snp.bottom).offset(32)
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
        titleLabel.text = detail.title
        ratingLabel.text = String(format: "%.1f", detail.voteAverage)
        overviewLabel.text = detail.overview
        yearItem.1.text = String(detail.releaseDate?.prefix(4) ?? "")
        durationItem.1.text = "\(detail.runtime ?? 0) Minutes"
        genreItem.1.text = detail.genres.first?.name ?? ""
        
        if let bPath = detail.backdropPath { backdropImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(bPath)")) }
        if let pPath = detail.posterPath { posterImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(pPath)")) }
    }

    private func createInfoItem(iconName: String) -> (UIStackView, UILabel) {
        let stack = UIStackView(); stack.spacing = 4
        let icon = UIImageView(image: UIImage(systemName: iconName)); icon.tintColor = .lightGray
        icon.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 12)
        label.textColor = .lightGray
        stack.addArrangedSubview(icon)
        stack.addArrangedSubview(label)
        return (stack, label)
    }
    
    private func createSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "indicatorView")
        view.snp.makeConstraints { make in
            make.width.equalTo(2)
            make.height.equalTo(16)
        }
        return view
    }
}
