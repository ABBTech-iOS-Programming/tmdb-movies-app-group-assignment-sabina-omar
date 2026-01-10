//
//  RatingBadgeView.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 10.01.26.
//

import UIKit
import SnapKit

final class RatingBadgeView: UIView {
    
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        return UIVisualEffectView(effect: blurEffect)
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
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addViews()
        setupConstraints()
    }
    
    private func setupUI() {
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = UIColor(named: "ratingView")
    }
    
    private func addViews() {
        [blurEffectView, starIcon, ratingLabel].forEach(addSubview)
    }
    
    private func setupConstraints() {
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
    }
    
    func configure(with rating: Double) {
        ratingLabel.text = String(format: "%.1f", rating)
    }
}
