//
//  MovieDetail.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//


import Foundation

struct MovieDetail: Codable {
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

struct Genre: Codable {
    let id: Int
    let name: String
}

struct CreditsResponse: Codable {
    let cast: [Cast]
}

struct Cast: Codable {
    let name: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
    }
}
