//
//  EmptyStateView.swift
//  MoviesApp
//
//  Created by Omar Yunusov on 10.01.26.
//


import UIKit
import SnapKit

final class EmptyStateView: UIView {

    private let containerView = UIView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.white.withAlphaComponent(0.6)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(containerView)

        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)

        
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-60)
            make.horizontalEdges.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(320)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(32)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(32)
            make.bottom.equalToSuperview()
        }
    }

    // MARK: - Configure
    func configure(image: UIImage?, title: String, subtitle: String) {
        imageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
