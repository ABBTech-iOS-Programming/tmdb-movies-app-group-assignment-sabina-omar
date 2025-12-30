//
//  PostsEndpoints.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 30.12.25.
//


import Foundation

enum PostsEndpoints {
    case getPosts
}

extension PostsEndpoints: Endpoint {
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .getPosts:
            return "/posts"

        }
       
    }
    
    var method: HttpMethod {
        switch self {
        case .getPosts:
            return .get
        }
    }
    
    var headers: [String : String]? {
       return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var httpBody: (any Encodable)? {
        return nil
    }
}
