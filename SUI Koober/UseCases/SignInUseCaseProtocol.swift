//
//  SignInUseCaseProtocol.swift
//  SUI Koober
//
//  Created by Miguel Lorenzo on 17/3/2025.
//  Copyright © 2025 Razeware. All rights reserved.
//

import Foundation
import Combine

/// Protocol that allows the abstraction of `SignInUseCase` for improving testability.
protocol SignInUseCaseProtocol {
    func start() -> AnyPublisher<UserSession, ErrorMessage>
}
