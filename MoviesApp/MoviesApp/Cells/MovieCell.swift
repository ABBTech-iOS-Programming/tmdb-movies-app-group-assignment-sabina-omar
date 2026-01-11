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
        let yearText = String(movie.releaseDate?.prefix(4) ?? "N/A")
        
        movieHeader.configure(
            title: movie.title,
            year: yearText,
            duration: "Movie",
            genre: "Action",
            rating: movie.voteAverage,
            posterPath: movie.posterPath
        )
    }
    
    func configure(with movie: MovieDetail) {
        let durationText: String
        if let runtime = movie.runtime, runtime > 0 {
            durationText = "\(runtime) Minutes"
        } else {
            durationText = "N/A"
        }
        
        let genreText = movie.genres.first?.name ?? "N/A"
        let yearText = String(movie.releaseDate?.prefix(4) ?? "N/A")
        
        movieHeader.configure(
            title: movie.title,
            year: yearText,
            duration: durationText,
            genre: genreText,
            rating: movie.voteAverage,
            posterPath: movie.posterPath
        )
    }
}
