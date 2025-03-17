//
//  PostRowCell.swift
//  SampleProject
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import UIKit

final class PostRowCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let postRowView = PostRowView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func configure() {
        
        contentView.addSubview(postRowView)
        postRowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                postRowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppDesign.Spacing.small),
                postRowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppDesign.Spacing.small),
                postRowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppDesign.Spacing.small),
                postRowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -AppDesign.Spacing.small)
            ]
        )
    }
    
    // MARK: - Public
    
    func updateContent(with post: Post) {
        postRowView.updateContent(from: post)
    }
}
