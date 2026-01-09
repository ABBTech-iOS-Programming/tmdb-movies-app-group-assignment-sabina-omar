//
//  CategoriesMovieCell.swift
//  MoviesApp
//
//  Created by Omar Yunusov on 09.01.26.
//

import UIKit
import SnapKit

final class CategoriesMovieViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: CategoriesMovieViewCell.self)
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let indicatorView = AppIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public methods
    func config(with category: MovieCategory) {
        categoryLabel.text = category.title
    }
    
    //MARK: Private methods
    private func setupUI() {
        setupSubview()
        setupConstraints()
    }

    private func setupConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        indicatorView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.width.equalTo(categoryLabel.snp.width)
            make.height.equalTo(4)
            make.bottom.equalToSuperview().offset(-4) 
        }
        indicatorView.isHidden = true
    }

    private func setupSubview() {
        contentView.addSubview(categoryLabel)
        contentView.addSubview(indicatorView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
    }
    
    override var isSelected: Bool {
        didSet {
            categoryLabel.textColor = isSelected ? .white : .lightGray
            indicatorView.isHidden = true
            
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        }
        }
}
