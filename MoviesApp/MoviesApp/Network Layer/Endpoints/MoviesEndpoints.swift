//
//  MoviesEndpoints.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 03.01.26.
//


import Foundation
enum MoviesEndpoints {
    case trending
    case nowPlaying
    case popular
    case upcoming
    case topRated
}
extension MoviesEndpoints: Endpoint {
    var baseURL: String {
        Constants.baseURL
    }
    var path: String {
        switch self {
        case .trending: return "/3/trending/movie/day"
        case .nowPlaying: return "/3/movie/now_playing"
        case .popular: return "/3/movie/popular"
        case .upcoming: return "/3/movie/upcoming"
            case .topRated: return "/3/movie/top_rated" }
    }
    var method: HttpMethod { .get }
    
    var headers: [String: String]? {
        
        [ "Authorization": "Bearer \(Constants.tmdbToken)", "Content-Type": "application/json", "Accept": "application/json" ]
    }
    
    var queryItems: [URLQueryItem]? { nil }
    var httpBody: Encodable? { nil }
}
