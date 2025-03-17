//
//  PostsViewModelTests.swift
//  SampleProjectTests
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import XCTest

class MockService: NetworkingService {
    
    func request<T>(router: Routable) async -> Result<T, Error> where T : Decodable, T : Encodable {
        return .success(
            [
                Post(id: 0, title: "First", body: "dsadjiasodjsaidoasjd"),
                Post(id: 1, title: "Second", body: "dsadjiasodjsaidoasjd")
            ] as! T
        )
    }
}

class PostsViewModelTests: XCTestCase {
    
    func testViewModel() async {
        
        let viewModel = PostsViewModel(service: MockService())
        
        await viewModel.fetchPosts()
        
        XCTAssertFalse(viewModel.posts.isEmpty)
        XCTAssertTrue(viewModel.posts.first!.title == "First")
        XCTAssertTrue(viewModel.posts.last!.id == 1)
    }
}

