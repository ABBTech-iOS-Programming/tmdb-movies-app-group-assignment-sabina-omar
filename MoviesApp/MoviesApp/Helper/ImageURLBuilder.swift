//
//  ImageURLBuilder.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 06.01.26.
//


import Foundation

struct ImageURLBuilder {
    private static let baseImageURL = "https://image.tmdb.org/t/p/"
    
    enum ImageSize: String {
        case small = "w200"
        case medium = "w500"
        case large = "w780"
        case original = "original"
    }
    
    static func poster(path: String, size: ImageSize = .medium) -> URL? {
        return URL(string: "\(baseImageURL)\(size.rawValue)\(path)")
    }
    
    static func backdrop(path: String, size: ImageSize = .large) -> URL? {
        return URL(string: "\(baseImageURL)\(size.rawValue)\(path)")
    }
}
