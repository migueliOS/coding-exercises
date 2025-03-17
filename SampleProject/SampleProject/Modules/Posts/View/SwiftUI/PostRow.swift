//
//  PostRow.swift
//  SampleProject
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import SwiftUI

struct PostRow: View {
    
    @Environment(\.design) var design
    
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(post.title)
                .foregroundStyle(design.Semantic.Colors.text)
                .font(design.Semantic.Fonts.title.suiFont)
            Text(post.body)
                .foregroundStyle(design.Semantic.Colors.textSecondary)
                .font(design.Semantic.Fonts.body.suiFont)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(design.Spacing.small)
        .background(design.Semantic.Colors.viewPrimaryBackground)
        .cornerRadius(design.CornerRadius.standard)
        .padding(design.Spacing.small)
    }
}
