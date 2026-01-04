//
//  NetworkError.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 30.12.25.
//

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case encodingError
    case serverError(statusCode: Int)
    case unknown(Error)
}
