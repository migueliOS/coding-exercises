//
//  PostRowView.swift
//  SampleProject
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import UIKit

final class PostRowView: UIView {
    
    // MARK: - UI Properties
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = AppDesign.Spacing.small
        stackView.axis = .vertical
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppDesign.Semantic.Fonts.title
        label.textColor = AppDesign.Semantic.Colors.text.uiColor
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = "PostRowView-Title"
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppDesign.Semantic.Fonts.subtitle
        label.textColor = AppDesign.Semantic.Colors.textSecondary.uiColor
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = "PostRowView-Subtitle"
        return label
    }()
    
    private var customConstraints: [NSLayoutConstraint] = []
    
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
        backgroundColor = AppDesign.Semantic.Colors.viewPrimaryBackground.uiColor
        layer.cornerRadius = AppDesign.CornerRadius.standard
        layer.masksToBounds = true
        
        addSubviews()
        refreshConstraints()
    }
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
    }
    
    private func refreshConstraints() {
        customConstraints.isEmpty ? () : NSLayoutConstraint.deactivate(customConstraints)
        customConstraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: AppDesign.Spacing.small),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -AppDesign.Spacing.small),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppDesign.Spacing.small),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppDesign.Spacing.small)
        ]
        NSLayoutConstraint.activate(customConstraints)
    }
    
    // MARK: - Public
    
    func updateContent(from post: Post) {
        titleLabel.text = post.title
        subtitleLabel.text  = post.body
    }
}
