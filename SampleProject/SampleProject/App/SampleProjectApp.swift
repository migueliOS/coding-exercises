//
//  SampleProjectApp.swift
//  SampleProject
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import SwiftUI

@main
struct SampleProjectApp: App {
    @State private var showSwiftUIView = false
    @State private var showUIKitView = false
    
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 20) {
                Button("Open SwiftUI View") {
                    showSwiftUIView = true
                }
                .fullScreenCover(isPresented: $showSwiftUIView) {
                    PostList(viewModel: .init(service: Service()))
                }
                
                Button("Open UIKit ViewController") {
                    showUIKitView = true
                }
                .fullScreenCover(isPresented: $showUIKitView) {
                    PostViewControllerRepresentable()
                }
            }
            .padding()
            .design(AppDesign.self)
        }
    }
}
