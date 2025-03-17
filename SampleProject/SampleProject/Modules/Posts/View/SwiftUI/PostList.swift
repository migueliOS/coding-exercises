//
//  PostList.swift
//  SampleProject
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import SwiftUI

struct PostList: View {
    
    @Environment(\.design) var design
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel: PostsViewModel
    
    init(viewModel: PostsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.posts) { post in
                PostRow(post: post)
            }
            .scrollContentBackground(.hidden)
            .background(design.Semantic.Colors.viewSecondaryBackground)
            .task {
                await viewModel.fetchPosts()
            }
            .navigationTitle("Posts")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(AppDesign.Semantic.Colors.text)
                }
            }
        }
    }
}
