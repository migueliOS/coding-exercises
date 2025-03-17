//
//  SignInUseCaseTests.swift
//  SUI KooberTests
//
//  Created by Miguel Lorenzo on 17/3/2025.
//  Copyright © 2025 Razeware. All rights reserved.
//

import XCTest
import Combine

class MockSignInUseCaseSuccess: SignInUseCaseProtocol {
    
    func start() -> AnyPublisher<UserSession, ErrorMessage> {
        Future { promise in
            promise(.success(UserSession.fake))
        }
        .eraseToAnyPublisher()
    }
}

class MockSignInUseCaseFailed: SignInUseCaseProtocol {
    
    func start() -> AnyPublisher<UserSession, ErrorMessage> {
        Future { promise in
            promise(.failure(ErrorMessage(message: "Failed to Sign In")))
        }
        .eraseToAnyPublisher()
    }
}

final class SignInUseCaseTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
   
    func test_MockSignInUseCaseSuccess() {
        let useCase = MockSignInUseCaseSuccess()
        let expectation = XCTestExpectation(description: "Sign-in Success and Returns a `UserSession`")
        
        useCase.start()
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected Success. Error: \(error.localizedDescription)")
                }
            } receiveValue: { session in
                XCTAssertEqual(session, UserSession.fake)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }
    
    func test_MockSignInUseCaseFailure() {
        let useCase = MockSignInUseCaseFailed()
        let expectation = XCTestExpectation(description: "Sign-in Fails")
        
        useCase.start()
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error.message, "Failed to Sign In")
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure")
                }
            } receiveValue: { session in
                XCTFail("Expected failure")
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }
    
    func test_SuccessfulLogin() {
        let useCase = SignInUseCase(
            username: "test",
            password: "test",
            remoteAPI: FakeUserAuthenticationRemoteAPI(success: true),
            userSessionStore: FakeUserSessionStore(userAlreadySignedIn: false)
        )
        
        let expectation = XCTestExpectation(description: "Sign in succeeds")
        useCase.start()
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success. Error \(error.localizedDescription)")
                }
            } receiveValue: { session in
                XCTAssertNotNil(session)
                XCTAssertEqual(session, UserSession.fake)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_FailedLoginUnauthorised() {
        let useCase = SignInUseCase(
            username: "test",
            password: "test",
            remoteAPI: FakeUserAuthenticationRemoteAPI(success: false, errorType: .unauthorized),
            userSessionStore: FakeUserSessionStore(userAlreadySignedIn: false)
        )
        
        let expectation = XCTestExpectation(description: "Sign in failse with unauthorised error")
        useCase.start()
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error.message, "Sign in failed. Please try again")
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure")
                }
            } receiveValue: { session in
                XCTFail("Expected failure")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_FailedLoginUnknown() {
        let useCase = SignInUseCase(
            username: "test",
            password: "test",
            remoteAPI: FakeUserAuthenticationRemoteAPI(success: false, errorType: .unknown),
            userSessionStore: FakeUserSessionStore(userAlreadySignedIn: false)
        )
        
        let expectation = XCTestExpectation(description: "Sign in fails with unknown error")
        useCase.start()
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error.message, "Unknown error occured. Please try again.")
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure")
                }
            } receiveValue: { session in
                XCTFail("Expected failure")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_SuccessfulLoginAlreadySignedIn() {
        let useCase = SignInUseCase(
            username: "test",
            password: "test",
            remoteAPI: FakeUserAuthenticationRemoteAPI(success: true),
            userSessionStore: FakeUserSessionStore(userAlreadySignedIn: true)
        )
        
        let expectation = XCTestExpectation(description: "Sign in succeeds")
        useCase.start()
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success. Error \(error.localizedDescription)")
                }
            } receiveValue: { session in
                XCTAssertNotNil(session)
                XCTAssertEqual(session, UserSession.fake)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_SuccessfulLoginStoreFailes() {
        let useCase = SignInUseCase(
            username: "test",
            password: "test",
            remoteAPI: FakeUserAuthenticationRemoteAPI(success: true),
            userSessionStore: FakeUserSessionStore(userAlreadySignedIn: true, shouldFail: true)
        )
        
        let expectation = XCTestExpectation(description: "Sign in succeeds but storing fails")
        useCase.start()
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error.message, "Unknown error. Please try again.")
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure")
                }
            } receiveValue: { session in
                XCTFail("Expected failure")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_UserAlreadySignedInStoredSession() {
        let store = FakeUserSessionStore(userAlreadySignedIn: true)
        let expectation = XCTestExpectation(description: "Should return stored `UserSession`")
        store.getStoredAuthenticatedUserSession()
            .sink { _ in
            } receiveValue: { session in
                XCTAssertNotNil(session)
                XCTAssertEqual(session, UserSession.fake)
                expectation.fulfill()
            }
            .store(in: &cancellables)
    
        wait(for: [expectation], timeout: 5)
    }
    
    func test_UserNotSignedInInStoredSession() {
        let store = FakeUserSessionStore(userAlreadySignedIn: false)
        let expectation = XCTestExpectation(description: "Should return `nil`")
        store.getStoredAuthenticatedUserSession()
            .sink { _ in
            } receiveValue: { session in
                XCTAssertNil(session)
                expectation.fulfill()
            }
            .store(in: &cancellables)
    
        wait(for: [expectation], timeout: 5)
    }
}
