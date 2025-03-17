//
//  PostListView.swift
//  SampleProject
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import UIKit

final class PostListView: UIView {
    
    // MARK: - Data
    
    var posts: [Post] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - UI Properties
    
    private let collectionView: UICollectionView
    private var customConstraints: [NSLayoutConstraint] = []
    private let layout = UICollectionViewFlowLayout()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = AppDesign.Spacing.medium
        layout.minimumInteritemSpacing = AppDesign.Spacing.small
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func configure() {
        addSubviews()
        configureSubviews()
        refreshConstraints()
    }
    
    private func addSubviews() {
        addSubview(collectionView)
    }
    
    private func configureSubviews() {
        backgroundColor = AppDesign.Semantic.Colors.viewPrimaryBackground.uiColor
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = AppDesign.Semantic.Colors.viewSecondaryBackground.uiColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PostRowCell.self, forCellWithReuseIdentifier: "PostRowCell")
    }
    
    private func refreshConstraints() {
        customConstraints.isEmpty ? () : NSLayoutConstraint.deactivate(customConstraints)
        customConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor)
        ]
        NSLayoutConstraint.activate(customConstraints)
    }
}

// MARK: - CollectionView

extension PostListView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PostRowCell",
            for: indexPath
        ) as? PostRowCell else {
            return UICollectionViewCell()
        }
        
        let post = posts[indexPath.item]
        cell.updateContent(with: post)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let post = posts[indexPath.item]
        
        let titleFont = AppDesign.Semantic.Fonts.title
        let subtitleFont = AppDesign.Semantic.Fonts.subtitle
        let horizontalPadding: CGFloat = AppDesign.Spacing.small * 4 // inside and outside margins
        let verticalPadding: CGFloat = AppDesign.Spacing.small * 3 // top, middle, bottom
        let interLabelSpacing: CGFloat = AppDesign.Spacing.small
        let layoutSpacing = layout.minimumLineSpacing
        
        let availableWidth = collectionView.bounds.width - horizontalPadding
         
        let titleHeight = heightForText(post.title, font: titleFont, width: availableWidth)
        let subtitleHeight = heightForText(post.body, font: subtitleFont, width: availableWidth)
        
        let totalHeight = verticalPadding + titleHeight + interLabelSpacing + subtitleHeight + layoutSpacing
        
        return CGSize(width: collectionView.bounds.width, height: totalHeight)
    }
    
    private func heightForText(_ text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = (text as NSString)
            .boundingRect(
                with: constraintRect,
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                attributes: [.font: font],
                context: nil
            )
        return ceil(boundingBox.height)
    }
}
