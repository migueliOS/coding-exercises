//
//  Routable.swift
//  SampleProject
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import Foundation

protocol Routable {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: String { get }
    var parameters: [URLQueryItem] { get }
}

extension Routable {
    
    var urlRequest: URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        parameters.isEmpty ? () : (components.queryItems = parameters)
        
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
