//
//  UserRouter.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation

enum UserRoute {
    case load
    case loadPost(Int)
}

protocol UserRouteable: AppRoutable {
    var route: UserRoute { get set }
}

extension UserRouteable {
    
    var path: any PathDefinitionProtocol {
        switch route {
        case let .loadPost(userId): return UsersPath.path(.posts, [userId])
        case .load: return UsersPath.path(.users, [])
        }
    }
    
    var method: HttpMethod {
        switch route {
        case .load: return .get
        case .loadPost: return .get
        }
    }
}

struct UserRouter: UserRouteable {
    var route: UserRoute
}
