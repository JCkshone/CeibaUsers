//
//  UsersCoordinator.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation
import SwiftUI

public enum UsersCoordinator: Router {
    case list
    case showPost(userId: Int)
    
    public var transition: NavigationType {
        switch self {
        default: return .push
        }
    }
    
    @ViewBuilder
    public func view() -> some View {
        switch self {
        case .list: UsersScreenView()
        case let .showPost(userId): PostsScreenView(userId: userId)
        }
    }
}
