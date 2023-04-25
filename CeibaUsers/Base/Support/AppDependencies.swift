//
//  AppDependencies.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation
import Resolver

public enum AppDependencies {
    public static func bindComponents() {

        // MARK: - Use Cases
        Resolver.register { UserUseCase() as UsersUseCaseProtocol }

        // MARK: - Network
        Resolver.register { NetworkProvider() as NetworkProviderProtocol }

        // MARK: - Stores
        Resolver.register {
            Store<UsersState, UsersAction>(
                state: .neverLoaded,
                reducer: UsersReducer.reduce(state:action:),
                middlewares: [
                    UsersMiddleware.executeLoadUsers(),
                    UsersMiddleware.executeLoadPost(),
                ]
            )
        }.scope(.cached)
    }
}

