//
//  Movie.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//


struct Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}