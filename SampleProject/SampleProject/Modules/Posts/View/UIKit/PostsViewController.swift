//
//  PostsViewController.swift
//  SampleProject
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import UIKit
import Combine

final class PostsViewController: UIViewController {
    
    private let viewModel: PostsViewModel
    private var customConstraints: [NSLayoutConstraint] = []
    
    // MARK: - UI Properties
    
    private let postListView = PostListView()
    
    // MARK: - Lifecycle
    
    init(viewModel: PostsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    init() {
        fatalError(#function + " not available")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private
    
    private var cancellables = Set<AnyCancellable>()
    
    private func configure() {
        
        view.backgroundColor = AppDesign.Semantic.Colors.viewPrimaryBackground.uiColor
        title = "Posts"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            systemItem: .close,
            primaryAction: UIAction(
                handler: { [weak self] _ in
                    DispatchQueue.main.async {
                        self?.dismiss(animated: true)
                    }
                }
            )
        )
        
        addSubviews()
        refreshConstraints()
        configureObservers()
        
        Task {
            await viewModel.fetchPosts()
        }
        
    }
    
    private func configureObservers() {
        
        viewModel.$posts.sink { [weak self] posts in
            guard let self else { return }
            DispatchQueue.main.async {
                self.postListView.posts = posts
            }
        }
        .store(in: &cancellables)
    }
    
    private func addSubviews() {
        postListView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postListView)
    }
    
    private func refreshConstraints() {
        customConstraints.isEmpty ? () : NSLayoutConstraint.deactivate(customConstraints)
        customConstraints = [
            postListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            postListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            postListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            postListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ]
        NSLayoutConstraint.activate(customConstraints)
    }
}
