//
//  MovieDetail.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//


import Foundation

struct MovieDetail: Decodable {
    let id: Int
    let title: String
    let overview: String
    let runtime: Int?
    let genres: [Genre]
    let releaseDate: String?
    let voteAverage: Double
    let posterPath: String?
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime, genres
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
}