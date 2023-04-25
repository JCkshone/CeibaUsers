//
//  UsersMiddleware.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation
import Resolver
import Combine

enum UsersMiddleware {
    @Injected private static var userUseCase: UsersUseCaseProtocol
        
    static func executeLoadUsers() -> Middleware<UsersState, UsersAction> {
        { _, action in
            guard case .loadUsers = action else { return Empty().eraseToAnyPublisher() }
        
            return userUseCase
                .execute()
                .map { .loadUsersSuccess($0) }
                .catch { log(error: $0, dispatch: .loadUsersFailure($0)) }
                .eraseToAnyPublisher()
        }
    }
    
    static func executeLoadPost() -> Middleware<UsersState, UsersAction> {
        { _, action in
            guard case let .loadPosts(userId) = action else { return Empty().eraseToAnyPublisher() }
        
            return userUseCase
                .execute(with: userId)
                .map { .loadPostsSuccess($0) }
                .catch { log(error: $0, dispatch: .loadPostsFailure($0)) }
                .eraseToAnyPublisher()
        }
    }
}

extension UsersMiddleware {
    private static func log(error: Error, dispatch: UsersAction) -> AnyPublisher<UsersAction, Never> {
        debugPrint("[\(String(describing: self))] Causal: \(error)")
        return Just(dispatch).setFailureType(to: Never.self).eraseToAnyPublisher()
    }
}
