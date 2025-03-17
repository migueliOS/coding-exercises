//
//  CenteredContentScrollView.swift
//  SUI Koober
//
//  Created by Miguel Lorenzo on 17/3/2025.
//  Copyright © 2025 Razeware. All rights reserved.
//

import SwiftUI

/// Presents the injected content `Content: View` centered in a `ScrollView`
/// by calculating the vertical space that is result from subtracting the `parent's height`
/// with the `content's height`.
struct CenteredContentScrollView<Content: View>: View {
    let content: Content
    
    @State private var contentHeight: CGFloat = 0
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Spacer(minLength: max((geometry.size.height - contentHeight) / 2, 0))
                    content
                        .readHeight($contentHeight)
                    Spacer(minLength: max((geometry.size.height - contentHeight) / 2, 0))
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

// MARK: - Preference Key

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

// MARK: - View modifier

struct HeightReader: ViewModifier {
    @Binding var height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: HeightPreferenceKey.self,
                            value: geometry.size.height
                        )
                }
            )
            .onPreferenceChange(HeightPreferenceKey.self) { value in
                height = value
            }
    }
}

// MARK: - Extensions

extension View {
    func readHeight(_ height: Binding<CGFloat>) -> some View {
        self.modifier(HeightReader(height: height))
    }
}
