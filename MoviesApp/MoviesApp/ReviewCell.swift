//
//  ReviewCell.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 08.01.26.
//


import UIKit
import SnapKit

final class ReviewCell: UITableViewCell {
    static let identifier = String(describing: ReviewCell.self)
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        imageView.image = .profilIcon
        return imageView
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Medium", size: 12)
        label.textColor = .white
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Medium", size: 12)
        label.textColor = UIColor(named: "selectedTabBar")
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with review: Review) {
        authorLabel.text = review.author
        contentLabel.text = review.content
        
        if let ratingValue = review.authorDetails.rating {
            ratingLabel.text = "\(ratingValue)"
        } else {
            ratingLabel.text = "N/A"
        }
    }
    
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        [
            authorLabel,
            contentLabel
        ].forEach(stackView.addArrangedSubview)
        
        [avatarImage , stackView, ratingLabel].forEach(contentView.addSubview)
    }
    
    private func setupConstraints() {
        avatarImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview()
            make.size.equalTo(44)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.centerX.equalTo(avatarImage)
            make.top.equalTo(avatarImage.snp.bottom).offset(12)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.top)
            make.leading.equalTo(avatarImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-12)
        }
        
    }
    
    
}
