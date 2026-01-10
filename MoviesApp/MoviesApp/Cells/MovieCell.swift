//
//  MovieCell.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 10.01.26.
//


import UIKit
import SnapKit
import Kingfisher

final class MovieCell: UITableViewCell {
    static let identifier = String(describing: MovieCell.self)
    private let movieHeader = MovieHeaderView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(movieHeader)
        movieHeader.applyListLayout()
        
        movieHeader.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }

    func configure(with movie: MovieDetail) {
        movieHeader.configure(
            title: movie.title,
            year: String(movie.releaseDate?.prefix(4) ?? ""),
            duration: "\(movie.runtime ?? 0) minutes",
            genre: movie.genres.first?.name ?? "N/A",
            rating: movie.voteAverage,
            posterPath: movie.posterPath
        )
    }
}
