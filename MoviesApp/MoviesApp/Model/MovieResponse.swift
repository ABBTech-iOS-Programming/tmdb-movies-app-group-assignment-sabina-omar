//
//  MovieResponse.swift
//  MoviesApp
//
//  Created by Omar Yunusov on 05.01.26.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}
