//
//  ReviewResponse.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 04.01.26.
//


import Foundation

struct ReviewResponse: Decodable {
    let results: [Review]
}

struct Review: Decodable {
    let id: String
    let author: String
    let content: String
    let authorDetails: AuthorDetails 
    
    enum CodingKeys: String, CodingKey {
        case id, author, content
        case authorDetails = "author_details"
    }
}

struct AuthorDetails: Decodable {
    let rating: Double?
}
