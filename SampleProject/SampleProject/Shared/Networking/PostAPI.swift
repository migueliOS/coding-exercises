//
//  PostAPI.swift
//  SampleProject
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import Foundation

enum PostAPI: Routable {
    case fetchPosts
    
    var scheme: String { "https" }
    
    var host: String { "jsonplaceholder.typicode.com" }
    
    var path: String {
        switch self {
        case .fetchPosts:
            return "/posts"
        }
    }
    
    var method: String { "GET" }
    
    var parameters: [URLQueryItem] { [] }
}
