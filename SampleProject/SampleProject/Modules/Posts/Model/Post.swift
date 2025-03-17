//
//  Post.swift
//  SampleProject
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    var body: String
}
