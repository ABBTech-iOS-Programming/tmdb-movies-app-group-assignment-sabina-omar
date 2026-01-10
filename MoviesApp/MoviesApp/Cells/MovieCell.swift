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

    func configure(with movie: Movie) {
        // Movie does not have runtime or genres, so provide sensible fallbacks
        movieHeader.configure(
            title: movie.title,
            year: String(movie.releaseDate?.prefix(4) ?? ""),
            duration: "_",
            genre: "_",
            rating: movie.voteAverage,
            posterPath: movie.posterPath
        )
    }
    
    func configure(with movie: MovieDetail) {
        let durationText: String
        if let runtime = movie.runtime, runtime > 0 {
            let hours = runtime / 60
            let minutes = runtime % 60
            durationText = hours > 0 ? "\(hours)h \(minutes)m" : "\(minutes)m"
        } else {
            durationText = "_"
        }
        
        let genreText = movie.genres.first?.name ?? "_"
        
        movieHeader.configure(
            title: movie.title,
            year: String(movie.releaseDate?.prefix(4) ?? ""),
            duration: durationText,
            genre: genreText,
            rating: movie.voteAverage,
            posterPath: movie.posterPath
        )
    }
}

