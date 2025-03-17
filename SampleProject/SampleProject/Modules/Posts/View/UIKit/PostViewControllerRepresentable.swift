//
//  PostViewControllerRepresentable.swift
//  SampleProject
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import UIKit
import SwiftUI

struct PostViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let controller = PostsViewController(viewModel: .init(service: Service()))
        return UINavigationController(rootViewController: controller)
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) { }
}
