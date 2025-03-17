//
//  PostsViewModel.swift
//  SampleProject
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import Foundation

class PostsViewModel: ObservableObject {
    
    private let service: NetworkingService
    
    @Published var posts: [Post] = []
    
    init(service: NetworkingService) {
        self.service = service
    }
    
    // MARK: - Public
    
    func fetchPosts() async {
        let result: Result<[Post], Error> = await service.request(router: PostAPI.fetchPosts)
        switch result {
        case .success(let posts):
            await MainActor.run {
                self.posts = posts
            }
        case .failure(let error):
            // Here we could update a @Published property like `state` to properly
            // provide the error feedback on the UI.
            print(error.localizedDescription)
        }
    }
}
