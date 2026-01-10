//
//  MovieHeaderView.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 10.01.26.
//


import UIKit
import SnapKit
import Kingfisher

final class MovieHeaderView: UIView {
    
    let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var ratingItem = createInfoItem(iconName: "star", iconColor: UIColor(named: "ratingLabel") ?? .systemOrange)
    private lazy var genreItem = createInfoItem(iconName: "ticket")
    private lazy var yearItem = createInfoItem(iconName: "calendar")
    private lazy var durationItem = createInfoItem(iconName: "clock")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [ratingItem.0, genreItem.0, yearItem.0, durationItem.0].forEach(infoStack.addArrangedSubview)
        [posterImage, titleLabel, infoStack].forEach(addSubview)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "infoStack")
        view.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(16)
        }
        return view
    }
    
    func applyListLayout() {
        titleLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        
        infoStack.axis = .vertical
        infoStack.spacing = 4
        [ratingItem.0, genreItem.0, yearItem.0, durationItem.0].forEach(infoStack.addArrangedSubview)
        ratingItem.0.isHidden = false
        
        updateInfoItems(fontName: "Poppins-Regular", color: .white)
        
        posterImage.snp.remakeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(95)
            make.height.equalTo(120)
        }
        
        titleLabel.snp.remakeConstraints { make in
            make.leading.equalTo(posterImage.snp.trailing).offset(12)
            make.trailing.equalToSuperview()
            make.top.equalTo(posterImage.snp.top).offset(4)
        }
        
        infoStack.snp.remakeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    func applyDetailLayout() {
        titleLabel.font = UIFont(name: "Poppins-SemiBold", size: 18)
            
        infoStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        infoStack.axis = .horizontal
        infoStack.spacing = 12
        infoStack.alignment = .center
        ratingItem.0.isHidden = true
        
        [
            yearItem.0,
            createSeparator(),
            durationItem.0,
            createSeparator(),
            genreItem.0
        ].forEach(infoStack.addArrangedSubview)
        
        
        updateInfoItems(fontName: "Montserrat-Medium", color: UIColor(named: "infoStack") ?? .lightGray)
    
        posterImage.snp.remakeConstraints { make in
            make.leading.top.equalToSuperview()
            make.width.equalTo(95)
            make.height.equalTo(120)
        }
        
        titleLabel.snp.remakeConstraints { make in
            make.leading.equalTo(posterImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(posterImage.snp.bottom).inset(12)
        }
        
        infoStack.snp.remakeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(24)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func updateInfoItems(fontName: String, color: UIColor) {
        [genreItem, yearItem, durationItem].forEach { item in
            item.1.font = UIFont(name: fontName, size: 12)
            item.1.textColor = color
            item.0.arrangedSubviews.first?.tintColor = color
        }
    }
    
    func configure(title: String, year: String, duration: String, genre: String, rating: Double, posterPath: String?) {
        titleLabel.text = title
        yearItem.1.text = year
        durationItem.1.text = duration
        genreItem.1.text = genre
        ratingItem.1.text = String(format: "%.1f", rating)
        ratingItem.1.textColor = UIColor(named: "ratingLabel")
        
        if let pPath = posterPath {
            posterImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(pPath)"))
        }
    }
    
    private func createInfoItem(iconName: String, iconColor: UIColor = .white) -> (UIStackView, UILabel) {
        let stack = UIStackView()
        stack.spacing = 8
        let icon = UIImageView(image: UIImage(systemName: iconName))
        icon.tintColor = iconColor
        icon.contentMode = .scaleAspectFit
        icon.snp.makeConstraints { make in make.size.equalTo(16) }
        
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textColor = iconColor
        
        stack.addArrangedSubview(icon)
        stack.addArrangedSubview(label)
        return (stack, label)
    }
}
