//
//  WatchlistResponse.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 02.01.26.
//

import Foundation

struct WatchlistResponse: Decodable {
    let results: [Movie]
}
