//
//  MovieDetail.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 02.01.26.
//


import Foundation

struct MovieDetail: Decodable {
    let id: Int
    let title: String
    let overview: String
    let runtime: Int?
    let genres: [Genre]
    let release_date: String?
    let vote_average: Double
    let poster_path: String?
    let backdrop_path: String?
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
