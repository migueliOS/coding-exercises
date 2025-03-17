//
//  NetworkingService.swift
//  SampleProject
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import Foundation

enum ServiceError: Error {
    case wrongUrl
}

protocol NetworkingService {
    
    func request<T: Codable>(router: Routable) async -> Result<T, Error>
}

class Service: NetworkingService {
    func request<T>(router: Routable) async -> Result<T, Error> where T : Decodable, T : Encodable {
        
        guard let urlRequest = router.urlRequest else {
            return .failure(ServiceError.wrongUrl)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let object = try JSONDecoder().decode(T.self, from: data)
            return .success(object)
        } catch {
            return .failure(error)
        }
    }
}
