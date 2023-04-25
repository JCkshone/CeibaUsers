//
//  UserUseCase.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation
import Combine
import Resolver

final class UserUseCase: UsersUseCaseProtocol {
    @Injected var network: NetworkProviderProtocol
    
    func execute() -> AnyPublisher<[UserModel], Error> {
        network.agent.run(
            UserRouter(route: .load)
        )
    }
    
    func execute(with userId: Int) -> AnyPublisher<[PostModel], Error> {
        network.agent.run(
            UserRouter(route: .loadPost(userId))
        )
    }
}
