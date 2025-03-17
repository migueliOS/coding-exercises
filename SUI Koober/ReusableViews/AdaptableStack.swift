//
//  AdaptableStack.swift
//  SUI Koober
//
//  Created by Miguel Lorenzo on 17/3/2025.
//  Copyright © 2025 Razeware. All rights reserved.
//

import SwiftUI

/// Presents the injected `Content: View` in a `VStack` unless
/// the content is displayed on an `iPhone` and on `landscape` orientation.
/// On which case, it will present the content on a `HStack`
struct AdaptableStack<Content: View>: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .phone {
                if verticalSizeClass == .compact {
                    // Landscape
                    HStack { content() }
                } else {
                    // Portrait
                    VStack { content() }
                }
            } else {
                VStack { content() }
            }
        }
    }
}
