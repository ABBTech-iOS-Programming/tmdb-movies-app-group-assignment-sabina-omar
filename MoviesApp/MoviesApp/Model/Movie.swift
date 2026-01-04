//
//  Movie.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//


struct Movie: Decodable {
    let id: Int
    let title: String
    let poster_path: String?
    let release_date: String?
    let vote_average: Double
}
