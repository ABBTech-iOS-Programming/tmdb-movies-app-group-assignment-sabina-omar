//
//  MovieReview.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 02.01.26.
//


import Foundation

struct ReviewResponse: Decodable {
    let results: [Review]
}

struct Review: Decodable {
    let id: String
    let author: String
    let content: String
    let created_at: String
}

