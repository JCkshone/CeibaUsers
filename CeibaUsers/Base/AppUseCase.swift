//
//  AppUseCase.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation
import Combine

protocol UsersUseCaseProtocol: AnyObject {
    func execute() -> AnyPublisher<[UserModel], Error>
    func execute(with userId: Int) -> AnyPublisher<[PostModel], Error>
}
